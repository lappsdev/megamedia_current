require 'rails_helper'

RSpec.describe "units#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/units/#{unit.id}", params: params
  end

  describe 'basic fetch' do
    let!(:unit) { create(:unit) }

    it 'works' do
      expect(UnitResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('units')
      expect(d.id).to eq(unit.id)
    end
  end
end
