class AddAdditionalInformationFieldToAuthorBooks < ActiveRecord::Migration
  def change
  	add_column :author_books, :additional_information, :text
  end
end
