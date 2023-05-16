require 'rails_helper'

RSpec.describe "medias#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/medias/#{media.id}"
  end

  describe 'basic destroy' do
    let!(:media) { create(:media) }

    it 'updates the resource' do
      expect(MediaResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Media.count }.by(-1)
      expect { media.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
