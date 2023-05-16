require 'rails_helper'

RSpec.describe UnitResource, type: :resource do
  describe 'serialization' do
    let!(:unit) { create(:unit) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(unit.id)
      expect(data.jsonapi_type).to eq('units')
    end
  end

  describe 'filtering' do
    let!(:unit1) { create(:unit) }
    let!(:unit2) { create(:unit) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: unit2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([unit2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:unit1) { create(:unit) }
      let!(:unit2) { create(:unit) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            unit1.id,
            unit2.id
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
            unit2.id,
            unit1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
