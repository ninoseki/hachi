# frozen_string_literal: true

RSpec.describe Hachi::Clients::Artifact, :vcr do
  let(:api) { Hachi::API.new }

  let(:case_id) { api.case.create(title: "test", description: "test")&.dig("_id") }
  let(:id) do
    api.artifact.create(case_id, data: "example.com", data_type: "domain", message: "test")&.first&.dig("_id")
  end

  describe "#create" do
    it "returns a hash" do
      res = api.artifact.create(case_id, data: "9.9.9.9", data_type: "ip", message: "test")
      expect(res).to be_an(Array)
    end
  end

  describe "#get_by_id" do
    it "returns a hash" do
      res = api.artifact.get_by_id(id)
      expect(res).to be_a(Hash)
    end
  end

  describe "#delete_by_id" do
    let(:id_to_delete) { api.artifact.create(case_id, data: "example.com", data_type: "domain", message: "test")&.first&.dig("_id") }

    it "returns an empty string" do
      res = api.artifact.delete_by_id(id_to_delete)
      expect(res.empty?).to eq(true)
    end
  end

  describe "#search" do
    let(:query) { { "_and": [{ "_or": [{ "_field": "data", "_value": "1.1.1.1" }, { "_field": "data", "_value": "example.com" }] }] } }

    it "return an array" do
      results = api.artifact.search(query)
      values = results.map { |result| result["data"] }

      input_values = %w(1.1.1.1 example.com)
      expect(values.all? { |v| input_values.include? v }).to be(true)
    end
  end

  describe "#similar" do
    it do
      res = api.artifact.similar(id)
      expect(res).to be_an(Array)
    end
  end
end
