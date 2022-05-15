# frozen_string_literal: true

RSpec.describe Hachi::Clients::Alert, :vcr do
  let(:api) { Hachi::API.new }
  let(:payload) do
    {
      type: "test",
      source: "test",
      sourceRef: "1",
      title: "alert title",
      description: "alert description",
      observables: [
        { dataType: "url", data: "http://example.org" },
        { dataType: "mail", data: "foo@example.org" }
      ]
    }
  end

  let(:alert) do
    api.alert.create(**payload)
  end

  let(:id) { alert&.dig("_id") }

  describe "#get_by_id" do
    it "retuns a hash" do
      res = api.alert.get_by_id(id)
      expect(res).to be_a(Hash)
    end
  end

  describe "#delete_by_id" do
    let(:id_to_delete) do
      payload[:title] = "Test to delete"
      payload[:source] = "delete"
      api.alert.create(**payload)&.dig("_id")
    end

    it "retuns an empty string" do
      res = api.alert.delete_by_id(id_to_delete)
      expect(res.empty?).to be true
    end
  end

  describe "#update" do
    let(:id_to_update) do
      payload[:title] = "Test to post"
      payload[:source] = "update"
      api.alert.create(**payload)&.dig("_id")
    end

    let(:attributes) { { title: "Updated", description: "Updated" } }

    it do
      res = api.alert.update(id_to_update, **attributes)
      expect(res).to be_a(String)
    end
  end
end
