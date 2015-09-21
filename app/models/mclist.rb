class Mclist < ActiveRecord::Base
  attr_accessible :key, :list_id,:pricings_attributes,:grouping_id
  # attr_accessor :pricings_attributes

  has_many :pricings, :dependent => :destroy
  accepts_nested_attributes_for :pricings
end
