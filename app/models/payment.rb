class Payment < ActiveRecord::Base
  attr_accessible :author_book_id,:card_numbre,:card_code,:card_exp_date,:token,:charge_id
  belongs_to :author_book
end
