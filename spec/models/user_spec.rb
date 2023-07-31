RSpec.describe User, type: :model do
  describe "Factory" do
    it "should be valid" do
      expect(create(:user)).to be_valid
    end
  end

  describe "Database table" do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :created_at }
    it { is_expected.to have_db_column :updated_at }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of :name }
  end

  describe "Relations" do
    it { is_expected.to have_many(:sleep_wake_time) }
    it { is_expected.to have_many(:follow_association_1) }
    it { is_expected.to have_many(:follow_association_2) }
  end

  describe "Delete dependent settings" do
    it "sleep record is deleted when associated user is deleted from the database" do
      FactoryBot.create(:sleep_wake_time)
      SleepWakeTime.last.user.destroy
      expect(SleepWakeTime.all.length).to eq 0
    end

    it "follow association is deleted when associated user requesting the follow is deleted from the database" do
      FactoryBot.create(:follow_association)
      FollowAssociation.last.requested_by_user.destroy
      expect(FollowAssociation.all.length).to eq 0
    end

    it "follow association is deleted when associated user being followed is deleted from the database" do
      FactoryBot.create(:follow_association)
      FollowAssociation.last.user_to_follow.destroy
      expect(FollowAssociation.all.length).to eq 0
    end
  end
end
