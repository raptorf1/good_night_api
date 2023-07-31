RSpec.describe FollowAssociation, type: :model do
  describe "Factory" do
    it "should be valid" do
      expect(create(:follow_association)).to be_valid
    end
  end

  describe "Database table" do
    it { is_expected.to have_db_column :requested_by_user_id }
    it { is_expected.to have_db_column :user_to_follow_id }
    it { is_expected.to have_db_column :created_at }
    it { is_expected.to have_db_column :updated_at }
  end

  describe "Associations" do
    it { is_expected.to belong_to(:requested_by_user) }
    it { is_expected.to belong_to(:user_to_follow) }
  end
end
