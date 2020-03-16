FactoryBot.define do
  factory :desk do
    name { Faker::GreekPhilosophers.name }
    price_per_day { rand(5..25) }

    trait :with_ongoing_contract do
      after(:build) do |desk|
        create(:contract, desk: desk)
      end
    end
  end
end
