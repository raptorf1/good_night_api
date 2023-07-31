class FollowAssociation < ApplicationRecord
  belongs_to :requested_by_user, class_name: "User"
  belongs_to :user_to_follow, class_name: "User"

  def self.check_follow_association_exists_before_creating(params_requested_by_user_id, params_user_to_follow_id)
    FollowAssociation.find_by(
      requested_by_user_id: params_requested_by_user_id,
      user_to_follow_id: params_user_to_follow_id
    )
  end
end
