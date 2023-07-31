class CreateFollowAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :follow_associations do |t|
      t.references :requested_by_user, foreign_key: { to_table: 'users' }
      t.references :user_to_follow, foreign_key: { to_table: 'users' }
      t.timestamps
    end
  end
end
