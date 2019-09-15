# frozen_string_literal: true

RSpec.describe Hachi::Models::User do
  let(:name) { "test" }
  let(:login) { "test" }
  let(:roles) { %w(read) }
  let(:password) { "test" }

  describe "#initialize" do
    it "doesn't raise an error" do
      described_class.new(name: name, login: login, roles: roles, password: password)
    end
  end

  context "when given an invalid input" do
    it do
      expect { described_class.new(name: name, login: login, roles: "foo", password: password) }.to raise_error(ArgumentError)
    end

    it do
      expect { described_class.new(name: name, login: login, roles: %w(foo bar), password: password) }.to raise_error(ArgumentError)
    end
  end
end
