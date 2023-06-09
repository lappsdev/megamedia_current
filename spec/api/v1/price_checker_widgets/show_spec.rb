require 'rails_helper'

RSpec.describe "price_checker_widgets#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/price_checker_widgets/#{price_checker_widget.id}", params: params
  end

  describe 'basic fetch' do
    let!(:price_checker_widget) { create(:price_checker_widget) }

    it 'works' do
      expect(PriceCheckerWidgetResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('price_checker_widgets')
      expect(d.id).to eq(price_checker_widget.id)
    end
  end
end
