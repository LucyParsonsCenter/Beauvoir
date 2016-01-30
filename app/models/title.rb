class Title < ApplicationRecord
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :categories

  def to_s
    self.name
  end
end
