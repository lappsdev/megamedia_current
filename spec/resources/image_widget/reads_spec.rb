require 'rails_helper'

RSpec.describe ImageWidgetResource, type: :resource do
  describe 'serialization' do
    let!(:image_widget) { create(:image_widget) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(image_widget.id)
      expect(data.jsonapi_type).to eq('image_widgets')
    end
  end

  describe 'filtering' do
    let!(:image_widget1) { create(:image_widget) }
    let!(:image_widget2) { create(:image_widget) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: image_widget2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([image_widget2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:image_widget1) { create(:image_widget) }
      let!(:image_widget2) { create(:image_widget) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            image_widget1.id,
            image_widget2.id
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
            image_widget2.id,
            image_widget1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
