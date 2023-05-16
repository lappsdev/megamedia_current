require 'rails_helper'

RSpec.describe "groups#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/groups/#{group.id}"
  end

  describe 'basic destroy' do
    let!(:group) { create(:group) }

    it 'updates the resource' do
      expect(GroupResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Group.count }.by(-1)
      expect { group.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
