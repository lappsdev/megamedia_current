require 'rails_helper'

RSpec.describe VideoWidgetResource, type: :resource do
  describe 'serialization' do
    let!(:video_widget) { create(:video_widget) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(video_widget.id)
      expect(data.jsonapi_type).to eq('video_widgets')
    end
  end

  describe 'filtering' do
    let!(:video_widget1) { create(:video_widget) }
    let!(:video_widget2) { create(:video_widget) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: video_widget2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([video_widget2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:video_widget1) { create(:video_widget) }
      let!(:video_widget2) { create(:video_widget) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            video_widget1.id,
            video_widget2.id
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
            video_widget2.id,
            video_widget1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
