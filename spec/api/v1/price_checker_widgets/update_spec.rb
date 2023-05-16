require 'rails_helper'

RSpec.describe "price_checker_widgets#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/price_checker_widgets/#{price_checker_widget.id}", payload
  end

  describe 'basic update' do
    let!(:price_checker_widget) { create(:price_checker_widget) }

    let(:payload) do
      {
        data: {
          id: price_checker_widget.id.to_s,
          type: 'price_checker_widgets',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(PriceCheckerWidgetResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { price_checker_widget.reload.attributes }
    end
  end
end
