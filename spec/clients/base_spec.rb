# frozen_string_literal: true

RSpec.describe Hachi::Clients::Base do
  let(:api_endpoint) { "http://locahost" }
  let(:api_key) { "key" }

  describe "#validate_range" do
    subject { described_class.new(api_endpoint: api_endpoint, api_key: api_key) }

    context "when given a valid range" do
      let(:ranges) { %w(0-1 all 0-100 1-100) }

      it "returns true" do
        ranges.each do |range|
          expect(subject.send(:validate_range, range)).to be(true)
        end
      end
    end

    context "when given an invalid range" do
      let(:ranges) { %w(1 test 100-0) }

      it "raise an ArgumentError" do
        ranges.each do |range|
          expect { subject.send(:validate_range, range) }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
