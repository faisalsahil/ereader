class AddPaymentsfieldsToPayment < ActiveRecord::Migration
  def change
 	  	add_column :payments , :card_numbre, :string
 	  	add_column :payments , :card_code, :string
 	  	add_column :payments , :card_exp_date, :string
 	  	add_column :payments , :author_book_id, :integer
 	  	add_column :payments , :token, :string
 	  	add_column :payments , :charge_id, :string

  end
end
