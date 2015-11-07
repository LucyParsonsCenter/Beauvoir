class TitleListMembership < ActiveRecord::Base
  belongs_to :title
  belongs_to :title_list, :touch => true
end
