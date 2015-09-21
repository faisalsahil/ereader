class CreateMclists < ActiveRecord::Migration
  def change
    create_table :mclists do |t|
      t.string :key
      t.string :list_id

      t.timestamps
    end
  end
end
