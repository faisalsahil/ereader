class ChageFieldFromAuthorBook < ActiveRecord::Migration
  def change
  	remove_column :author_books, :amazone_link
  	remove_column :author_books, :amazone_star_rating
  	add_column  :author_books, :amazon_link, :string
  	add_column :author_books, :amazon_star_rating,:string
  end
end
