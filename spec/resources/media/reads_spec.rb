require 'rails_helper'

RSpec.describe MediaResource, type: :resource do
  describe 'serialization' do
    let!(:media) { create(:media) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(media.id)
      expect(data.jsonapi_type).to eq('medias')
    end
  end

  describe 'filtering' do
    let!(:media1) { create(:media) }
    let!(:media2) { create(:media) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: media2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([media2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:media1) { create(:media) }
      let!(:media2) { create(:media) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            media1.id,
            media2.id
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
            media2.id,
            media1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
