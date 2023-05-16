require 'rails_helper'

RSpec.describe SchedulerResource, type: :resource do
  describe 'serialization' do
    let!(:scheduler) { create(:scheduler) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(scheduler.id)
      expect(data.jsonapi_type).to eq('schedulers')
    end
  end

  describe 'filtering' do
    let!(:scheduler1) { create(:scheduler) }
    let!(:scheduler2) { create(:scheduler) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: scheduler2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([scheduler2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:scheduler1) { create(:scheduler) }
      let!(:scheduler2) { create(:scheduler) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            scheduler1.id,
            scheduler2.id
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
            scheduler2.id,
            scheduler1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
