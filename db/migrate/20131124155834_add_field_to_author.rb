class AddFieldToAuthor < ActiveRecord::Migration
  def change
  	add_column :author_books , :genre_price, :string
  end
end
