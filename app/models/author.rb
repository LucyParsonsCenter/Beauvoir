class Author < ApplicationRecord
  has_many :authorships
  has_many :titles, through: :authorships

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
