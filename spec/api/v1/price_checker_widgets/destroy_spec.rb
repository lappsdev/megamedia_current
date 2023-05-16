require 'rails_helper'

RSpec.describe "price_checker_widgets#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/price_checker_widgets/#{price_checker_widget.id}"
  end

  describe 'basic destroy' do
    let!(:price_checker_widget) { create(:price_checker_widget) }

    it 'updates the resource' do
      expect(PriceCheckerWidgetResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { PriceCheckerWidget.count }.by(-1)
      expect { price_checker_widget.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
