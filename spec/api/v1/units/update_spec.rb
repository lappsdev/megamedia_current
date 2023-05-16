require 'rails_helper'

RSpec.describe "units#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/units/#{unit.id}", payload
  end

  describe 'basic update' do
    let!(:unit) { create(:unit) }

    let(:payload) do
      {
        data: {
          id: unit.id.to_s,
          type: 'units',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(UnitResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { unit.reload.attributes }
    end
  end
end
