# frozen_string_literal: true

RSpec.describe Hachi::Clients::User, :vcr do
  let(:api) { Hachi::API.new }
  let(:login) { "georges" }
  let(:name) { "Georges Abitbol" }
  let(:roles) { %w(read write) }
  let(:password) { "La classe" }

  let(:id) { api.user.create(login: login, name: name, roles: roles, password: password)&.dig("_id") }

  describe "#get_by_id" do
    it do
      res = api.user.get_by_id(id)
      expect(res).to be_a(Hash)
    end
  end

  describe "#create" do
    let(:login) { "foo" }

    it do
      res = api.user.create(login: login, name: name, roles: roles, password: password)
      expect(res).to be_a(Hash)
    end
  end

  describe "#delete_by_id" do
    let(:login) { "delete" }
    let(:id) { api.user.create(login: login, name: name, roles: roles, password: password)&.dig("_id") }

    it do
      res = api.user.delete_by_id(id)
      expect(res.empty?).to be true
    end
  end

  describe "#current" do
    it do
      res = api.user.current
      expect(res).to be_a(Hash)
    end
  end
end
