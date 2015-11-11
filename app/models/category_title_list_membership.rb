class CategoryTitleListMembership < ActiveRecord::Base
  belongs_to :title_list
  belongs_to :category
end
