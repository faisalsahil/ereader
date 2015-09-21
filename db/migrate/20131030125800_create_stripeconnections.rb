class CreateStripeconnections < ActiveRecord::Migration
  def change
    create_table :stripeconnections do |t|
      t.string :access_token
      t.string :email
      t.string :ref_token
      t.string :token_type
      t.string :stripe_user_id

      t.timestamps
    end
  end
end
