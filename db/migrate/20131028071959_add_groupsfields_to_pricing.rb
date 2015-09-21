class AddGroupsfieldsToPricing < ActiveRecord::Migration
  def change
  	  	  	add_column :pricings , :group_name, :string
  	  	  	add_column :pricings , :group_id, :string

  end
end
