class Edition < ActiveRecord::Base
  belongs_to :title,   :touch=>true
  has_many :copies
  has_many :purchase_order_line_items
  has_many :invoice_line_items
  has_many :distributors, :through => :copies
  belongs_to :publisher

  validate :isbns_are_valid
  before_validation :normalize_isbns
  before_save :copy_isbns

  monetize :list_price_cents

  scope :published, -> { where(:in_print => true) }
  scope :newest_first, -> { order("year_of_publication desc") }
  scope :without_edition, lambda {|e| e ? {:conditions => ["id != ?", e.id]} : {} }

  def has_copies_in_stock?
    copies.with_state(:in_stock).length > 0
  end

  def my_stock_status
    if has_copies_in_stock? 
      "In stock" 
    elsif in_print?
      "Out of stock"
    else
      "Out of print"
    end
  end

  def my_online_price
    has_copies_in_stock? ? copies.with_state(:in_stock).order("price_in_cents desc").first.price : ""
  end

  def self.formats
    ['Hardcover','Paperback','Pamphlet','Magazine','Journal','CD','DVD','Clothing','Coffee','Other','Ships free']
  end

  def to_s
    "#{number}  (#{format} #{year_of_publication})"
  end

  def isbn
    isbn13
  end

  def isbns_are_valid
    unless isbn10.blank? || Lisbn.new(isbn10).valid?
      errors.add(:isbn10,"not valid")
    end

    unless isbn13.blank? || Lisbn.new(isbn13).valid?
      errors.add(:isbn13,"not valid")
    end
  end

  def copy_isbns
    if isbn10.blank? && !isbn13.blank?
      self.isbn10=Lisbn.new(isbn13).isbn10
    end
    if isbn13.blank? && !isbn10.blank?
      self.isbn13=Lisbn.new(isbn10).isbn13
    end
  end

  protected
  def normalize_isbns
    isbn10.gsub!(/[^0-9X]/,'') unless isbn10.nil?
    isbn13.gsub!(/[^0-9X]/,'') unless isbn13.nil?
  end
end
