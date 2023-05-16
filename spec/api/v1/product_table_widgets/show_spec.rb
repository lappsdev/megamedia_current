require 'rails_helper'

RSpec.describe "product_table_widgets#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/product_table_widgets/#{product_table_widget.id}", params: params
  end

  describe 'basic fetch' do
    let!(:product_table_widget) { create(:product_table_widget) }

    it 'works' do
      expect(ProductTableWidgetResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('product_table_widgets')
      expect(d.id).to eq(product_table_widget.id)
    end
  end
end
