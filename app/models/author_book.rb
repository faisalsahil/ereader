class AuthorBook < ActiveRecord::Base
  attr_accessible :additional_information,:template,:genre_price,:retailers_attributes,:links_retailers,:rb_price,:pb_price,:name,:phone,:email,:amazon_link,:amazon_star_rating,:payment_status,:genres,:title, :author_name,:status,:preferred_start_date,:flexible,:preferred_end_date
  # ,:payment_attributes
  has_one :payment, :dependent => :destroy
  has_one :scheduleing, :dependent => :destroy
  has_many :retailers

	# validates :rb_price, presence: true
	validates :rb_price, presence: true
	validates :title, presence: true
	validates :pb_price, presence: true
 	validates :title, presence: true
 	validates :author_name, presence: true
	# validates :preferred_start_date, presence: true
    # validates :preferred_end_date, presence: true
 	validates :name, presence: true
	validates :email, presence: true, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
	validates :amazon_link, presence: true
	validates :amazon_star_rating, presence: true
	validates :payment_status, presence: true
	validates :genres, presence: true

  accepts_nested_attributes_for :retailers
end
