require 'rails_helper'

RSpec.describe "product_table_widgets#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/product_table_widgets", params: params
  end

  describe 'basic fetch' do
    let!(:product_table_widget1) { create(:product_table_widget) }
    let!(:product_table_widget2) { create(:product_table_widget) }

    it 'works' do
      expect(ProductTableWidgetResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['product_table_widgets'])
      expect(d.map(&:id)).to match_array([product_table_widget1.id, product_table_widget2.id])
    end
  end
end
