require 'rails_helper'

RSpec.describe GroupResource, type: :resource do
  describe 'serialization' do
    let!(:group) { create(:group) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(group.id)
      expect(data.jsonapi_type).to eq('groups')
    end
  end

  describe 'filtering' do
    let!(:group1) { create(:group) }
    let!(:group2) { create(:group) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: group2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([group2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:group1) { create(:group) }
      let!(:group2) { create(:group) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            group1.id,
            group2.id
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
            group2.id,
            group1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
