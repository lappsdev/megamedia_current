require 'rails_helper'

RSpec.describe "groups#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/groups/#{group.id}", payload
  end

  describe 'basic update' do
    let!(:group) { create(:group) }

    let(:payload) do
      {
        data: {
          id: group.id.to_s,
          type: 'groups',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(GroupResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { group.reload.attributes }
    end
  end
end
