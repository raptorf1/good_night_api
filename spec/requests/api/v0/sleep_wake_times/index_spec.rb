RSpec.describe "GET /api/v0/sleep_wake_times", type: :request do
  describe "succesfully" do
    describe "when no sleep records exist in the DB" do
      before { get "/api/v0/sleep_wake_times" }

      it "with 200 status" do
        expect(response.status).to eq 200
      end

      it "with correct number of results" do
        expect(json_response.count).to eq 0
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
        expect(json_response.count).to eq 3
      end

      it "with correct fields returned" do
        json_response.each do |sleep_record|
          expect(sleep_record).to include("sleep", "wake", "difference", "created_at", "user")
        end
      end

      it "with correct order returned (created_at ASC)" do
        expect(json_response.first["created_at"].to_datetime < json_response.second["created_at"].to_datetime)
        expect(json_response.second["created_at"].to_datetime < json_response.third["created_at"].to_datetime)
      end
    end
  end
end
