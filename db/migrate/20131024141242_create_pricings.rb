class CreatePricings < ActiveRecord::Migration
  def change
    create_table :pricings do |t|
      t.integer :mclist_id
      t.string :price

      t.timestamps
    end
  end
end
