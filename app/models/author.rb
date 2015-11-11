class Author < ActiveRecord::Base
  has_many :contributions
  has_many :titles, :through => :contributions

  before_save :set_first_last_and_full_name

  def to_s
    full_name
  end

  def set_first_last_and_full_name 
    if (full_name && (first_name.blank?  && last_name.blank?))
        split_name=full_name.rpartition(" ")
        self.first_name=split_name[0]
        self.last_name=split_name[2]
    else
      self.full_name = "#{first_name} #{last_name}"
    end
  end

  def name_and_id
    "#{full_name} (#{id})"
  end

  def name_and_id_and_titles
    "#{full_name} (#{id}) [#{titles.length} title(s)]"
  end
end
