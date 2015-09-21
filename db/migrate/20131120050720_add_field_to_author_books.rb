class AddFieldToAuthorBooks < ActiveRecord::Migration
  def change
  	add_column :author_books , :links_retailers, :string
  end
end
