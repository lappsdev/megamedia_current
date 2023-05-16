require 'rails_helper'

RSpec.describe QueueCallerWidgetResource, type: :resource do
  describe 'serialization' do
    let!(:queue_caller_widget) { create(:queue_caller_widget) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(queue_caller_widget.id)
      expect(data.jsonapi_type).to eq('queue_caller_widgets')
    end
  end

  describe 'filtering' do
    let!(:queue_caller_widget1) { create(:queue_caller_widget) }
    let!(:queue_caller_widget2) { create(:queue_caller_widget) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: queue_caller_widget2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([queue_caller_widget2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:queue_caller_widget1) { create(:queue_caller_widget) }
      let!(:queue_caller_widget2) { create(:queue_caller_widget) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            queue_caller_widget1.id,
            queue_caller_widget2.id
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
            queue_caller_widget2.id,
            queue_caller_widget1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
