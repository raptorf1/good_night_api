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

  describe "Relations" do
    it { is_expected.to have_many(:sleep_wake_time) }
  end
end
