require 'rails_helper'

RSpec.describe "schedulers#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/schedulers/#{scheduler.id}", params: params
  end

  describe 'basic fetch' do
    let!(:scheduler) { create(:scheduler) }

    it 'works' do
      expect(SchedulerResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('schedulers')
      expect(d.id).to eq(scheduler.id)
    end
  end
end
