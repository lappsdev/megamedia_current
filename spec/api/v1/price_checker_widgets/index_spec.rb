require 'rails_helper'

RSpec.describe "price_checker_widgets#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/price_checker_widgets", params: params
  end

  describe 'basic fetch' do
    let!(:price_checker_widget1) { create(:price_checker_widget) }
    let!(:price_checker_widget2) { create(:price_checker_widget) }

    it 'works' do
      expect(PriceCheckerWidgetResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['price_checker_widgets'])
      expect(d.map(&:id)).to match_array([price_checker_widget1.id, price_checker_widget2.id])
    end
  end
end
