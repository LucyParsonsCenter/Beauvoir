class TitleCategoryMembership < ActiveRecord::Base
  belongs_to :title
  belongs_to :category, :touch => true
end
