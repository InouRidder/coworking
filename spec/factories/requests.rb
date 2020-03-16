FactoryBot.define do
  factory :request do
    registration { association(:registration) }
    status { Request.statuses.keys.sample }
  end
end
