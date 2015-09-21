class MandrillSetting < ActiveRecord::Base
  attr_accessible :from_email,:from_name,:apr_subject,:apr_tempate,:rem_subject,:rem_template

  validates :from_email, :presence => true
  # validates :subject, :presence => true
  validates :from_name, :presence => true
  validates_presence_of :apr_subject, :apr_tempate,:rem_subject,:rem_template
end
