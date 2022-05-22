FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    given_name { Faker::Name.first_name }
    family_name { Faker::Name.last_name }
    user_role { 'trainer' }
  end
end
