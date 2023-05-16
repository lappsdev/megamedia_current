require 'rails_helper'

RSpec.describe "product_table_widgets#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/product_table_widgets", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:product_table_widget)
    end
    let(:payload) do
      {
        data: {
          type: 'product_table_widgets',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(ProductTableWidgetResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { ProductTableWidget.count }.by(1)
    end
  end
end
