RSpec.describe "POST /api/v0/users", type: :request do
  describe "succesfully" do
    before { post "/api/v0/users", params: { name: "Tania" } }

    it "with 200 status" do
      expect(response.status).to eq 200
    end

    it "with correct number of results saved in the DB" do
      expect(User.all.count).to eq 1
    end

    it "with correct name of result saved in the DB" do
      expect(User.all.first.name).to eq "Tania"
    end

    it "with correct message returned" do
      expect(json_response["message"]).to eq "User created successfully! Name: Tania, ID: #{User.all.first.id}"
    end
  end

  describe "unsuccesfully" do
    describe "when no name params are passed" do
      before { post "/api/v0/users" }

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with correct number of error messages" do
        expect(json_response["errors"].count).to eq 1
      end

      it "with correct error message" do
        expect(json_response["errors"].first).to eq "Name can't be blank"
      end

      it "with no record created in the DB" do
        expect(User.all.count).to eq 0
      end
    end

    describe "when empty string name params are passed" do
      before { post "/api/v0/users", params: { name: "   " } }

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with correct number of error messages" do
        expect(json_response["errors"].count).to eq 1
      end

      it "with correct error message" do
        expect(json_response["errors"].first).to eq "Name can't be blank"
      end

      it "with no record created in the DB" do
        expect(User.all.count).to eq 0
      end
    end
  end
end
