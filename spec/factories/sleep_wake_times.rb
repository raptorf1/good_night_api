FactoryBot.define do
  factory :sleep_wake_time do
    sleep { "2023-07-28 12:59:12" }
    wake { "2023-07-28 12:59:12" }
    difference { "" }
    association :user
  end
end
