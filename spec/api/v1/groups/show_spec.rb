require 'rails_helper'

RSpec.describe "groups#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/groups/#{group.id}", params: params
  end

  describe 'basic fetch' do
    let!(:group) { create(:group) }

    it 'works' do
      expect(GroupResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('groups')
      expect(d.id).to eq(group.id)
    end
  end
end
