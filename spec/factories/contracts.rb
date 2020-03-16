# frozen_literal_string: true

FactoryBot.define do
  factory :contract do
    start_date { Date.today }
    end_date { Date.today.end_of_month }
    status { 'paid' }
    total_price { 1 }
    user { association(:user) }
    desk { association(:desk) }

    trait :expired do
      start_date { Date.today - 35 }
      end_date { Date.today - 4 }
    end
  end
end
