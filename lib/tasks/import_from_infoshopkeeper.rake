# need an isk database running
namespace :infoshopkeeper do
  desc "Import from infoshopkeeper"
  task :import => :environment do
    
    isk_db="isk"
    isk_db_user="isk"
    isk_db_password="isk"

    only_do_books=true

    puts "Connecting to old database...."
    DB = Sequel.connect(:adapter => 'mysql2', :user => isk_db_user, :host => 'localhost', :database => isk_db,:password=>isk_db_password)    
    puts "Success!"			 
    

    titles=DB[:title]
    books=DB[:book]
    authors=DB[:author]
    titletags=DB[:titletag]
    author_title=DB[:author_title]


    #Get the list of titles from isk    
    if only_do_books
      titles_to_import=titles.where(:kind_id => 1)
    else
      titles_to_import=titles
    end
    
    c=0
    titles_to_import.each do |t|   # Only grab books
      if c>10
        next
      end
      c=c+1

      puts "Processing title: #{t[:booktitle]}"

      #each title becomes a borges title
      new_title=Title.new(:title => t[:booktitle] )
      
      unless t[:publisher].blank?
        new_publisher=Publisher.find_or_create_by_name(t[:publisher])
      end

      puts "past publisher!"

      old_isbn=Lisbn.new(t[:isbn])
      
      if old_isbn.valid?
        new_isbn10=old_isbn.isbn10
        new_isbn13=old_isbn.isbn13
        
        #We'll try openlibrary.org for a cover image
        new_cover_url="http://covers.openlibrary.org/b/isbn/#{new_isbn13}-L.jpg"
        
        #HIT GOOGLE API FOR DATE OF PUBLICATION
        gbooks = GoogleBooks.search('isbn:'+new_isbn13) # yields a collection of one result
        gbook = gbooks.first
        unless gbook.nil?
          gpublished_date=gbook.published_date
          unless gpublished_date.blank?
            new_published_date=gpublished_date[0,4]
          end
        end
      end
      

      #and each title gets its own unique edition
      new_edition=Edition.new(:isbn10=>new_isbn10,
                              :isbn13=>new_isbn13,
                              :publisher=>new_publisher,
                              :in_print=>true,
                              :year_of_publication => new_published_date,
                              :remote_cover_url => new_cover_url)
      
      #each book gets made into a copy attached to that edition

      books_for_title=books.where(:title_id => t[:id])


      
      books_for_title.each do |b|
        # new_copy = Copy.new(:cost => book[:wholesale], :price => book[:listprice], :inventoried_when => book[:inventoried_when], :deinventoried_when => book[:sold_when], :status => book[:status], :owner => (Owner.find_or_create_by_name(book[:owner]) unless book[:owner].blank?), :notes => book[:notes], :is_used => (book[:distributor] == "used" ? true : false))


        new_copy = Copy.new(:cost => b[:wholesale],
                            :price => b[:listprice],
                            :inventoried_when => b[:inventoried_when],
                            :deinventoried_when => b[:sold_when],
                            :status => b[:status],
                            :owner => (Owner.find_or_create_by_name(b[:owner]) unless b[:owner].blank?),
                            :notes => b[:notes],
                            :is_used => (b[:distributor] == "used" ? true : false),
                            )

        distrib = Distributor.find_or_create_by_name(b[:distributor]) unless b[:distributor].blank?
        if distrib
          distrib.copies << new_copy
        end
        
        unless new_copy.valid?
          puts new_copy.errors.messages
        end

        puts "get down here"
        new_edition.copies << new_copy

        puts new_copy.price
        puts new_copy.price_in_cents

        puts "get down here!"
        new_edition.list_price=new_edition.copies.collect{|c| c.price }.max
        puts "get down here!"
                                       
      end
      
      new_title.editions << new_edition

      puts "get down here!"
      author_titles = author_title.where(:title_id => t[:id])
      authors_for_title=author_titles.collect {|a_t| authors.where(:id => a_t[:author_id]).first}
      
      puts "author stuff!"



      # sunspot was having trouble here, commented out the searchable block

      authors_for_title.each do |a|
        new_title.authors << Author.find_or_create_by_full_name(a[:author_name])
      end

      puts "tag stuff!"
      
      tags=titletags.where(:title_id => t[:id],:tagkey => "section")
      tags.each do |tag|
        new_title.categories << Category.find_or_create_by_name(tag[:tagvalue])
      end

      puts "post tag stuff!"

      puts new_edition.copies.length

      new_title.save!
      puts "did we save it?"

    end
       
  end

end












