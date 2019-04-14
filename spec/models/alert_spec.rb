# frozen_string_literal: true

RSpec.describe Hachi::Models::Alert do
  describe "#initialize" do
    it "doesn't raise an error" do
      described_class.new(title: "test", description: "test", type: "test", source: "test")
    end
  end

  context "when given an invalid input" do
    it "raises an ArgumentError" do
      expect { described_class.new(tltle: "test") }.to raise_error(ArgumentError)
      expect { described_class.new(title: "test", description: "test", severity: 4) }.to raise_error(ArgumentError)
      expect { described_class.new(title: "test", description: "test", tlp: 4) }.to raise_error(ArgumentError)
      expect { described_class.new(title: "test", description: "test", status: "invalid") }.to raise_error(ArgumentError)
      expect { described_class.new(title: "test", description: "test", date: "invalid") }.to raise_error(ArgumentError)

      invalid_artifacts = [{}]
      expect { described_class.new(title: "test", description: "test", artifacts: invalid_artifacts) }.to raise_error(ArgumentError)
    end
  end
end
