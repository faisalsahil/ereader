# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stripe do
    email "MyString"
    access_token "MyString"
  end
end
