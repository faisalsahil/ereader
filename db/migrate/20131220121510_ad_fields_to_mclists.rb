class AdFieldsToMclists < ActiveRecord::Migration
  def change
  	add_column :mclists , :list_name, :string
  	add_column :mclists , :grouping_name, :string

  end
end
