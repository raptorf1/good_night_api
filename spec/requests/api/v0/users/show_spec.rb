RSpec.describe "GET /api/v0/users/:id", type: :request do
  let(:user_1) { FactoryBot.create(:user) }
  let(:user_2) { FactoryBot.create(:user) }
  let!(:follow_association) do
    FactoryBot.create(:follow_association, requested_by_user_id: user_1.id, user_to_follow_id: user_2.id)
  end

  describe "succesfully" do
    describe "when no sleep records exist in the DB for the user" do
      before { get "/api/v0/users/#{user_1.id}" }

      it "with 200 status" do
        expect(response.status).to eq 200
      end

      it "with correct result" do
        expect(json_response["payload"]["id"]).to eq user_1.id
      end

      it "with correct fields returned" do
        expect(json_response["payload"]).to include("id", "name", "sleep_records")
      end

      it "with correct number of sleep records returned" do
        expect(json_response["payload"]["sleep_records"].empty?).to eq true
      end
    end

    describe "when sleep records exist in the DB for the user and their friends" do
      before do
        FactoryBot.create(:sleep_wake_time, sleep: Time.now - 20.days, wake: Time.now - 19.days, user_id: user_1.id)
        FactoryBot.create(
          :sleep_wake_time,
          sleep: Time.now - 10.days,
          wake: Time.now - 9.days,
          difference: 51.0,
          user_id: user_1.id
        )
        FactoryBot.create(:sleep_wake_time, sleep: Time.now - 20.days, wake: Time.now - 19.days, user_id: user_2.id)
        FactoryBot.create(
          :sleep_wake_time,
          sleep: Time.now - 10.days,
          wake: Time.now - 9.days,
          difference: 52.0,
          user_id: user_2.id
        )
        get "/api/v0/users/#{user_1.id}"
      end

      it "with 200 status" do
        expect(response.status).to eq 200
      end

      it "with correct number of sleep records returned" do
        expect(json_response["payload"]["sleep_records"].count).to eq 2
      end

      it "with correct sleep record fields returned" do
        json_response["payload"]["sleep_records"].each do |sleep_record|
          expect(sleep_record).to include("id", "sleep", "wake", "difference", "created_at", "user")
        end
      end

      it "with correct order of sleep records returned (only those of previous week sorted by difference DSC)" do
        expect(json_response["payload"]["sleep_records"].first["difference"]).to eq 52.0
        expect(json_response["payload"]["sleep_records"].second["difference"]).to eq 51.0
      end
    end
  end

  describe "unsuccesfully" do
    describe "when user is not found" do
      before { get "/api/v0/users/15000" }

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with correct number of error messages" do
        expect(json_response["errors"].count).to eq 1
      end

      it "with correct error message" do
        expect(json_response["errors"].first).to eq "User not found!"
      end
    end
  end
end
