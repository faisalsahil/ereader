class CreateRetailers < ActiveRecord::Migration
  def change
    create_table :retailers do |t|
      t.integer :author_book_id
      t.string :retailer_link
      t.string :retailer_name

      t.timestamps
    end
  end
end
