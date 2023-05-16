require 'rails_helper'

RSpec.describe ProductTableWidgetResource, type: :resource do
  describe 'serialization' do
    let!(:product_table_widget) { create(:product_table_widget) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(product_table_widget.id)
      expect(data.jsonapi_type).to eq('product_table_widgets')
    end
  end

  describe 'filtering' do
    let!(:product_table_widget1) { create(:product_table_widget) }
    let!(:product_table_widget2) { create(:product_table_widget) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: product_table_widget2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([product_table_widget2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:product_table_widget1) { create(:product_table_widget) }
      let!(:product_table_widget2) { create(:product_table_widget) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            product_table_widget1.id,
            product_table_widget2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            product_table_widget2.id,
            product_table_widget1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
