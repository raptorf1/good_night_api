class FollowAssociation < ApplicationRecord
  belongs_to :requested_by_user, class_name: "User"
  belongs_to :user_to_follow, class_name: "User"
end
