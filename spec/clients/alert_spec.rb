# frozen_string_literal: true

RSpec.describe Hachi::Clients::Alert, :vcr do
  let(:api) { Hachi::API.new }
  let(:title) { "Test Alert" }
  let(:description) { "test" }
  let(:type) { "test" }
  let(:source) { "test" }
  let(:artifacts) {
    [
      { data: "1.1.1.1", data_type: "ip", message: "test" },
      { data: "github.com", data_type: "domain", tags: ["test"] },
    ]
  }

  describe "#list" do
    it "retuns an array" do
      res = api.alert.list
      expect(res).to be_an(Array)
    end
  end

  describe "#get_by_id" do
    it "retuns a hash" do
      res = api.alert.get_by_id("e34a7adc35780454372f0567f951694e")
      expect(res).to be_a(Hash)
    end
  end

  describe "#create" do
    it "returns a hash" do
      res = api.alert.create(title: title, description: description, type: type, source: source)
      expect(res).to be_an(Hash)
    end

    context "create an alert with artifacts" do
      it "returns a hash" do
        res = api.alert.create(title: title, description: description, type: type, source: source, artifacts: artifacts)
        expect(res).to be_an(Hash)
      end
    end

    context "when raise an error" do
      it do
        expect { api.alert.create(title: title, description: description, type: type, source: source, tags: [["N/A"]]) }.to raise_error(Hachi::Error)
      end
    end
  end

  describe "#delete_by_id" do
    let(:id) { api.alert.create(title: title, description: description, type: type, source: source)&.dig("_id") }

    it "retuns an empty string" do
      res = api.alert.delete_by_id(id)
      expect(res.empty?).to be true
    end
  end

  describe "#search" do
    let(:attributes) { { title: title } }

    it do
      res = api.alert.search(attributes)
      expect(res).to be_an(Array)
    end
  end
end
