class ChangeColumntypeFrom < ActiveRecord::Migration
  def change
  	remove_column :author_books , :flexible
  	add_column :author_books , :flexible, :string
  end
end
