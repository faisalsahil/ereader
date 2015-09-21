# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stripeconnection do
    access_token "MyString"
    email "MyString"
    ref_token "MyString"
    token_type "MyString"
    stripe_user_id "MyString"
  end
end
