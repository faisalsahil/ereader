class AddNameToAuthorbooks < ActiveRecord::Migration
  def change
  	  	  	  	add_column :author_books , :name, :string
  	  	  	  	add_column :author_books , :phone, :string
  	  	  	  	add_column :author_books , :email, :string
  	  	  	  	add_column :author_books , :amazone_link, :string
  	  	  	  	add_column :author_books , :amazone_star_rating, :string
  	  	  	  	add_column :author_books , :payment_status, :string
  	  	  	  	
  end
end
