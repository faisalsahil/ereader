class Retailer < ActiveRecord::Base
  attr_accessible :author_book_id, :retailer_link, :retailer_name
  belongs_to :author_book
end
