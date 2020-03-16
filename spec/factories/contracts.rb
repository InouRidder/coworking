FactoryBot.define do
  factory :contract do
    start_date { "MyString" }
    end_date { "MyString" }
    status { "MyString" }
    total_price { 1 }
    user { nil }
    desk { nil }
  end
end
