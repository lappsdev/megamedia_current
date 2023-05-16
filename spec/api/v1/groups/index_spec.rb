require 'rails_helper'

RSpec.describe "groups#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/groups", params: params
  end

  describe 'basic fetch' do
    let!(:group1) { create(:group) }
    let!(:group2) { create(:group) }

    it 'works' do
      expect(GroupResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['groups'])
      expect(d.map(&:id)).to match_array([group1.id, group2.id])
    end
  end
end
