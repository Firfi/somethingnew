FactoryGirl.define  do
  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    sequence(:username) { |n| "user_#{n}" }
    password "secret"
  end
end