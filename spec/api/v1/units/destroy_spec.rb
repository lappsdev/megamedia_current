require 'rails_helper'

RSpec.describe "units#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/units/#{unit.id}"
  end

  describe 'basic destroy' do
    let!(:unit) { create(:unit) }

    it 'updates the resource' do
      expect(UnitResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Unit.count }.by(-1)
      expect { unit.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
