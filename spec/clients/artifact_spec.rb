# frozen_string_literal: true

RSpec.describe Hachi::Clients::Artifact, :vcr do
  let(:api) { Hachi::API.new }

  describe "#create" do
    it "returns a hash" do
      res = api.artifact.create("AWoZBct1H8Rbrc-EdGwH", data: "9.9.9.9", data_type: "ip", message: "test")
      expect(res).to be_a(Hash)
    end
  end

  describe "#get_by_id" do
    it "returns a hash" do
      res = api.artifact.get_by_id("e6b9ea938e00b088a468a86c38b7717c")
      expect(res).to be_a(Hash)
    end
  end

  describe "#delete_by_id" do
    let(:id) { api.artifact.create("AWoZBct1H8Rbrc-EdGwH", data: "example.com", data_type: "domain", message: "test")&.dig("_id") }

    it "returns an empty string" do
      res = api.artifact.delete_by_id(id)
      expect(res.empty?).to eq(true)
    end
  end

  describe "#search" do
    it "return an array" do
      res = api.artifact.search(data: "1.1.1.1", data_type: "ip")
      expect(res).to be_an(Array)
    end
  end
end
