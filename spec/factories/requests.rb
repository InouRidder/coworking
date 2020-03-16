FactoryBot.define do
  factory :request do
    registration { association(:registration) }
    status { Request.statuses.keys.sample }
    last_confirmation_email_sent_at { Date.today - rand(20) }
  end
end
