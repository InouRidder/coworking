FactoryBot.define do
  factory :user do
    registration { association(:registration) }
  end
end
