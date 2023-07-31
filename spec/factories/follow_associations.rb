FactoryBot.define do
  factory :follow_association do
    association :requested_by_user, factory: :user
    association :user_to_follow, factory: :user
  end
end
