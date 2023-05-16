require 'rails_helper'

RSpec.describe "price_checker_widgets#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/price_checker_widgets", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:price_checker_widget)
    end
    let(:payload) do
      {
        data: {
          type: 'price_checker_widgets',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(PriceCheckerWidgetResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { PriceCheckerWidget.count }.by(1)
    end
  end
end
