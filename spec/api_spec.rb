RSpec.describe Hachi::API, :vcr do
  let(:api) { Hachi::API.new }

  describe "#get" do
    it do
      res = api.get("/api/alert" ) { |json| json }
      expect(res).to be_an(Array)
    end
  end
end
