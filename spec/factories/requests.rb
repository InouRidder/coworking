FactoryBot.define do
  factory :request do
    registration { association(:registration) }
    status { Request.statuses.keys.sample }
    last_confirmation_email_sent_at { Date.today - rand(20) }
    last_confirmed_at { Date.today - rand(20..60) }
    created_at { Date.today - rand(60..90) }
  end
end
