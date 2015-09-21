class AddFieldsToMadrillsettings < ActiveRecord::Migration
  def change
  	add_column :mandrill_settings , :apr_subject, :string
  	add_column :mandrill_settings , :rem_subject, :string
  	add_column :mandrill_settings , :apr_tempate, :string
  	add_column :mandrill_settings , :rem_template, :string
  end
end
