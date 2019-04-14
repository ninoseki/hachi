# frozen_string_literal: true

RSpec.describe Hachi::Clients::Case, :vcr do
  let(:api) { Hachi::API.new }

  describe "#list" do
    it "retuns an array" do
      res = api.case.list
      expect(res).to be_an(Array)
    end
  end

  describe "#get_by_id" do
    it "retuns a hash" do
      res = api.case.get_by_id("AWobTO2jH8Rbrc-EdGw2")
      expect(res).to be_a(Hash)
    end
  end

  describe "#create" do
    it "returns a hash" do
      res = api.case.create(title: "test case", description: "test case")
      expect(res).to be_an(Hash)
    end
  end

  describe "#delete_by_id" do
    let(:id) { api.case.create(title: "test case", description: "test case")&.dig("_id") }

    it "retuns an empty string" do
      res = api.case.delete_by_id(id)
      expect(res.empty?).to be true
    end
  end

  describe "#search" do
    it "returns an array" do
      res = api.case.search("test")
      expect(res).to be_an(Array)
    end
  end
end
