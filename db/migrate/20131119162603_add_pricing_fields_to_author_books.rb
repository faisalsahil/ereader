class AddPricingFieldsToAuthorBooks < ActiveRecord::Migration
  def change
  	add_column :author_books , :rb_price, :string
  	add_column :author_books , :pb_price, :string
  end
end
