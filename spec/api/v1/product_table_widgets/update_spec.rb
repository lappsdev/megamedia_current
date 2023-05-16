require 'rails_helper'

RSpec.describe "product_table_widgets#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/product_table_widgets/#{product_table_widget.id}", payload
  end

  describe 'basic update' do
    let!(:product_table_widget) { create(:product_table_widget) }

    let(:payload) do
      {
        data: {
          id: product_table_widget.id.to_s,
          type: 'product_table_widgets',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(ProductTableWidgetResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { product_table_widget.reload.attributes }
    end
  end
end
