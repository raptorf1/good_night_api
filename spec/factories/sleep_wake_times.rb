FactoryBot.define do
  factory :sleep_wake_time do
    sleep { "2023-07-28 23:59:12" }
    wake { "2023-07-29 08:03:05" }
    difference { "" }
    association :user
  end
end
