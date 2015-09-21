class AddColumnToAuthorBooks < ActiveRecord::Migration
  def change
  	add_column :author_books, :title, :string
  	add_column :author_books, :author_name, :string
    add_column :author_books, :genres, :string
  	# add_column :author_books, :type, :string
  	# add_column :author_books, :Flat_rate_price, :string
  	# add_column :author_books, :bargain_price, :string
  	add_column :author_books, :status, :string
  	# add_column :author_books, :book_id, :string
  	add_column :author_books, :preferred_date, :date,:format => "%m/%d/%Y"
  	add_column :author_books, :flexible, :boolean, :default=> true

  end
end
