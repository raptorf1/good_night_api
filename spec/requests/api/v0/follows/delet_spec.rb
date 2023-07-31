RSpec.describe "DELETE /api/v0/follows/:id", type: :request do
  let(:follow_association) { FactoryBot.create(:follow_association) }

  describe "succesfully" do
    before { delete "/api/v0/follows/#{follow_association.id}" }

    it "with 200 status" do
      expect(response.status).to eq 200
    end

    it "with correct user results in the DB" do
      expect(FollowAssociation.all.count).to eq 0
    end

    it "with correct message returned" do
      expect(
        json_response["message"]
      ).to eq "You are no longer following User with name: #{follow_association.user_to_follow.name} and ID: #{follow_association.user_to_follow.id}."
    end
  end

  describe "unsuccesfully" do
    describe "when follow association is not found" do
      before { delete "/api/v0/follows/15000" }

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with correct number of error messages" do
        expect(json_response["errors"].count).to eq 1
      end

      it "with correct error message" do
        expect(json_response["errors"].first).to eq "Follow association not found!"
      end
    end
  end
end
