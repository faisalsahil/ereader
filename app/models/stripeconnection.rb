class Stripeconnection < ActiveRecord::Base
  attr_accessible :access_token, :email, :ref_token, :stripe_user_id, :token_type
end
