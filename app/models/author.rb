class Author < ApplicationRecord
  has_many :authorships
  has_many :titles, through: :authorships

  def to_s
    "#{self.first_name} #{self.last_name}"
  end
end
