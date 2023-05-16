require 'rails_helper'

RSpec.describe "schedulers#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/schedulers/#{scheduler.id}", payload
  end

  describe 'basic update' do
    let!(:scheduler) { create(:scheduler) }

    let(:payload) do
      {
        data: {
          id: scheduler.id.to_s,
          type: 'schedulers',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(SchedulerResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { scheduler.reload.attributes }
    end
  end
end
