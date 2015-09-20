class Contribution < ActiveRecord::Base
  belongs_to :author
  belongs_to :title

  def to_s
    if author 
      if ! what.blank? 
        "#{author.full_name} (#{what})"
      else
        author.full_name
      end
    else
      ""
    end  
  end

end
