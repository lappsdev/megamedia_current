require 'rails_helper'

RSpec.describe "product_table_widgets#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/product_table_widgets/#{product_table_widget.id}"
  end

  describe 'basic destroy' do
    let!(:product_table_widget) { create(:product_table_widget) }

    it 'updates the resource' do
      expect(ProductTableWidgetResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { ProductTableWidget.count }.by(-1)
      expect { product_table_widget.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
