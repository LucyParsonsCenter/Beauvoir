class PostCategory < ActiveRecord::Base
  has_many :post_category_memberships
  has_many :posts,:through => :post_category_memberships

end
