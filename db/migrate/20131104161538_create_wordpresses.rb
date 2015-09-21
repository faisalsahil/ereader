class CreateWordpresses < ActiveRecord::Migration
  def change
    create_table :wordpresses do |t|
      t.string :path

      t.timestamps
    end
  end
end
