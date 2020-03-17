FactoryBot.define do
  factory :registration do
    email { Faker::Internet.email }
    password { 'password' }
    name { Faker::Name.name }
    bio { Faker::Lorem.sentence(word_count: 55) }
    phone { '+33712345678' }
  end
end
