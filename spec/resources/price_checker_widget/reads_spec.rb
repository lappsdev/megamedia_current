require 'rails_helper'

RSpec.describe PriceCheckerWidgetResource, type: :resource do
  describe 'serialization' do
    let!(:price_checker_widget) { create(:price_checker_widget) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(price_checker_widget.id)
      expect(data.jsonapi_type).to eq('price_checker_widgets')
    end
  end

  describe 'filtering' do
    let!(:price_checker_widget1) { create(:price_checker_widget) }
    let!(:price_checker_widget2) { create(:price_checker_widget) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: price_checker_widget2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([price_checker_widget2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:price_checker_widget1) { create(:price_checker_widget) }
      let!(:price_checker_widget2) { create(:price_checker_widget) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            price_checker_widget1.id,
            price_checker_widget2.id
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
            price_checker_widget2.id,
            price_checker_widget1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
