FactoryBot.define do
  factory :user do
    name { Faker::Internet.unique.username }
    email { Faker::Internet.unique.email }
    password { 'password' }
  end
end
