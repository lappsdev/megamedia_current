require 'rails_helper'

RSpec.describe DeviceResource, type: :resource do
  describe 'serialization' do
    let!(:device) { create(:device) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(device.id)
      expect(data.jsonapi_type).to eq('devices')
    end
  end

  describe 'filtering' do
    let!(:device1) { create(:device) }
    let!(:device2) { create(:device) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: device2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([device2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:device1) { create(:device) }
      let!(:device2) { create(:device) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            device1.id,
            device2.id
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
            device2.id,
            device1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
