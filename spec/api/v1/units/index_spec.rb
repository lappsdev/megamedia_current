require 'rails_helper'

RSpec.describe "units#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/units", params: params
  end

  describe 'basic fetch' do
    let!(:unit1) { create(:unit) }
    let!(:unit2) { create(:unit) }

    it 'works' do
      expect(UnitResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['units'])
      expect(d.map(&:id)).to match_array([unit1.id, unit2.id])
    end
  end
end
