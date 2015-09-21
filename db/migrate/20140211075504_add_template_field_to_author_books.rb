class AddTemplateFieldToAuthorBooks < ActiveRecord::Migration
  def change
  	remove_column :author_books, :phone
  	add_column :author_books, :template, :string
  end
end
