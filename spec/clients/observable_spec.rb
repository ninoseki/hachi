# frozen_string_literal: true

RSpec.describe Hachi::Clients::Observable, :vcr do
  let(:api) { Hachi::API.new }

  let(:observable_id) do
    observables = api.query.query(**{
                                    query: [
                                      {
                                        _name: "listObservable"
                                      }
                                    ]
                                  })
    observables.first["_id"]
  end

  describe "#get_by_id" do
    it "retuns a hash" do
      res = api.observable.get_by_id(observable_id)
      expect(res).to be_a(Hash)
    end
  end
end
