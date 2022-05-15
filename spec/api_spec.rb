RSpec.describe Hachi::API, :vcr do
  let(:api) { Hachi::API.new }

  describe "#get" do
    it do
      res = api.get("/user/current") { |json| json }
      expect(res).to be_a(Hash)
    end
  end
end
