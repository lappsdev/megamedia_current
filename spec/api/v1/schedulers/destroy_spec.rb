require 'rails_helper'

RSpec.describe "schedulers#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/schedulers/#{scheduler.id}"
  end

  describe 'basic destroy' do
    let!(:scheduler) { create(:scheduler) }

    it 'updates the resource' do
      expect(SchedulerResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Scheduler.count }.by(-1)
      expect { scheduler.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
