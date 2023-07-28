RSpec.describe "GET /api/v0/users/:id", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "succesfully" do
    describe "when no sleep records exist in the DB for the user" do
      before { get "/api/v0/users/#{user.id}" }

      it "with 200 status" do
        expect(response.status).to eq 200
      end

      it "with correct result" do
        expect(json_response["id"]).to eq user.id
      end

      it "with correct fields returned" do
        expect(json_response).to include("id", "name", "sleep_records")
      end

      it "with correct number of sleep records returned" do
        expect(json_response["sleep_records"].empty?).to eq true
      end
    end

    describe "when sleep records exist in the DB for the user" do
      before do
        5.times { FactoryBot.create(:sleep_wake_time, user_id: user.id) }
        get "/api/v0/users/#{user.id}"
      end

      it "with 200 status" do
        expect(response.status).to eq 200
      end

      it "with correct number of sleep records returned" do
        expect(json_response["sleep_records"].count).to eq 5
      end

      it "with correct sleep record fields returned" do
        json_response["sleep_records"].each do |sleep_record|
          expect(sleep_record).to include("id", "sleep", "wake", "difference")
        end
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
