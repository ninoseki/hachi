# frozen_string_literal: true

RSpec.describe Hachi::Models::Artifact do
  context "when given an invalid input" do
    it "raises an ArgumentError" do
      expect { described_class.new(data: "1.1.1.1", invalid: "hoge") }.to raise_error(ArgumentError)
      expect { described_class.new(data: "1.1.1.1", data_type: "hoge") }.to raise_error(ArgumentError)
      expect { described_class.new(data: "1.1.1.1", data_type: "ip", tlp: 4) }.to raise_error(ArgumentError)
      expect { described_class.new(data: "1.1.1.1", data_type: "ip", tags: "invalid") }.to raise_error(ArgumentError)
    end
  end
end
