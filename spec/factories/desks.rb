FactoryBot.define do
  factory :desk do
    name { Faker::GreekPhilosophers.name }
    price_per_day { rand(5..25) }
  end
end
