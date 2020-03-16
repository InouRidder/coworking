FactoryBot.define do
  factory :registration do
    email { Faker::Internet.email }
    password { 'password' }
    name { Faker::Name.name }
    bio { Faker::GreekPhilosophers.quote }
    phone { '+3312345678' }
  end
end
