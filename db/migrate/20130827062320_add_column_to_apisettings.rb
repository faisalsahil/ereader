class AddColumnToApisettings < ActiveRecord::Migration
  def change
    add_column :apisettings, :api_key, :string
  end
end
