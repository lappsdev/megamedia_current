require 'rails_helper'

RSpec.describe "groups#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/groups", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:group)
    end
    let(:payload) do
      {
        data: {
          type: 'groups',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(GroupResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Group.count }.by(1)
    end
  end
end
