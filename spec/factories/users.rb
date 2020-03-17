FactoryBot.define do
  factory :user do
    registration { association(:registration) }
    status { 'active' }
  end
end
