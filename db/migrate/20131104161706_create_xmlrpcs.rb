class CreateXmlrpcs < ActiveRecord::Migration
  def change
    create_table :xmlrpcs do |t|
      t.string :path

      t.timestamps
    end
  end
end
