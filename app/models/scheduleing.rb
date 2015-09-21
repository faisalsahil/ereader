class Scheduleing < ActiveRecord::Base
  attr_accessible :author_book_id, :schedule_date
  belongs_to :author_book
end
