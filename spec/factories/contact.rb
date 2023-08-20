FactoryBot.define do
  factory :contact do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
  end
end
