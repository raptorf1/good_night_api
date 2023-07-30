RSpec.describe "GET /api/v0/sleep_wake_times", type: :request do
  describe "succesfully" do
    describe "when no sleep records exist in the DB" do
      before { get "/api/v0/sleep_wake_times" }

      it "with 200 status" do
        expect(response.status).to eq 200
      end

      it "with correct number of results" do
        expect(json_response["payload"].count).to eq 0
      end
    end

    describe "when sleep records exist in the DB" do
      before do
        3.times { FactoryBot.create(:sleep_wake_time) }
        get "/api/v0/sleep_wake_times"
      end

      it "with 200 status" do
        expect(response.status).to eq 200
      end

      it "with correct number of results" do
        expect(json_response["payload"].count).to eq 3
      end

      it "with correct fields returned" do
        json_response["payload"].each do |sleep_record|
          expect(sleep_record).to include("id", "sleep", "wake", "difference", "created_at", "user")
        end
      end

      it "with correct order returned (created_at DSC - newest record appears first)" do
        expect(
          json_response["payload"].first["created_at"].to_datetime >
            json_response["payload"].second["created_at"].to_datetime
        ).to eq true
        expect(
          json_response["payload"].second["created_at"].to_datetime >
            json_response["payload"].third["created_at"].to_datetime
        ).to eq true
      end
    end
  end
end
