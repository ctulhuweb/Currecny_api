require "rails_helper"

RSpec.describe "Currencies Management", type: :request do
  
  describe "#index" do
    before(:each) do
      create_list(:currency, 10)
    end

    it "return currencies" do
      get currencies_path, headers: { "Authorization": "Bearer E76dyVeBAiFuudXTYVt4zQXB" }
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it "return part currencies with pagination" do
      get currencies_path(page: 2, per_page: 5), headers: { "Authorization": "Bearer E76dyVeBAiFuudXTYVt4zQXB" }
      expect(JSON.parse(response.body).size).to eq(5)
    end
  end

  describe "#show" do
    it "return currency rate" do
      cur = create(:currency)
      get currency_path(cur), headers: { "Authorization": "Bearer E76dyVeBAiFuudXTYVt4zQXB" }
      expect(JSON.parse(response.body)["rate"]).to eq cur.rate.to_s
      expect(response).to have_http_status(:success)
    end

    it "return error if not found record" do
      get currency_path(100), headers: { "Authorization": "Bearer E76dyVeBAiFuudXTYVt4zQXB" }
      expect(JSON.parse(response.body)["error"]).to include("Record not found")
      expect(response).to have_http_status(:not_found)
    end
  end
  
  context "without authorization token" do
    it "return error" do
      get currencies_path
      expect(JSON.parse(response.body)["error"]).to include("Not Authorized")
    end
  end
end