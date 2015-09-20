class Event < ActiveRecord::Base
  belongs_to :event_location

  has_many :event_shifts
  has_many :event_staffers,:through => :event_shifts
  has_many :event_title_links
  has_many :titles, :through => :event_title_links 


  validates :event_start, :presence => true  
  validates :event_end, :presence => true
  validates :title, :presence => true
  validates :event_location, :presence => true
  
  mount_uploader :picture, ImageUploader  

  accepts_nested_attributes_for :event_shifts, :allow_destroy => true
  accepts_nested_attributes_for :event_title_links, :allow_destroy => true  

  def self.by_month(month)
    where('extract(month from event_start) = ?', month)
  end

  def self.by_year(year)
    where('extract(year from event_start) = ?', year)
  end

  def start_time
    event_start
  end



end
