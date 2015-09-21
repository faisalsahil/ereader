class AddEmailToMclists < ActiveRecord::Migration
  def change
  	  	add_column :mclists , :email, :string

  end
end
