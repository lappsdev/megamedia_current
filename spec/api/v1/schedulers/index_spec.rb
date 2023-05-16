require 'rails_helper'

RSpec.describe "schedulers#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/schedulers", params: params
  end

  describe 'basic fetch' do
    let!(:scheduler1) { create(:scheduler) }
    let!(:scheduler2) { create(:scheduler) }

    it 'works' do
      expect(SchedulerResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['schedulers'])
      expect(d.map(&:id)).to match_array([scheduler1.id, scheduler2.id])
    end
  end
end
