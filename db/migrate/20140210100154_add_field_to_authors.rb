class AddFieldToAuthors < ActiveRecord::Migration
  def change
  	remove_column :author_books, :preferred_date
  	add_column :author_books, :preferred_end_date, :date, :format => "%m/%d/%Y"
  	add_column :author_books, :preferred_start_date,:date,:format => "%m/%d/%Y"
  end
end
