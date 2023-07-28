RSpec.describe SleepWakeTime, type: :model do
  describe "Factory" do
    it "should be valid" do
      expect(create(:sleep_wake_time)).to be_valid
    end
  end

  describe "Database table" do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :sleep }
    it { is_expected.to have_db_column :wake }
    it { is_expected.to have_db_column :difference }
    it { is_expected.to have_db_column :created_at }
    it { is_expected.to have_db_column :updated_at }
  end

  describe "Associations" do
    it { is_expected.to belong_to(:user) }
  end
end
