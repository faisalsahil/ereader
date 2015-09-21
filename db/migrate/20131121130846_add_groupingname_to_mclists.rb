class AddGroupingnameToMclists < ActiveRecord::Migration
  def change
  	add_column :mclists , :grouping_id, :integer
  end
end
