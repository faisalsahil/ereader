class AddchangecolumnFromPricing < ActiveRecord::Migration
  def change
  	remove_column :pricings , :price
  	add_column :pricings , :tier_1, :string
  	add_column :pricings , :tier_2, :string
  	add_column :pricings , :tier_3, :string

  end
end
