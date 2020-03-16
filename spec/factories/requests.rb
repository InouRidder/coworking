FactoryBot.define do
  factory :request do
    registration { association(:registration) }
  end
end
