class Pricing < ActiveRecord::Base
  attr_accessible :mclist_id, :tier_1,:tier_2,:tier_3,:group_name,:group_id

  belongs_to :mclist
end
