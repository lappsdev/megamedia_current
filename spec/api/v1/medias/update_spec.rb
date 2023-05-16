require 'rails_helper'

RSpec.describe "medias#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/medias/#{media.id}", payload
  end

  describe 'basic update' do
    let!(:media) { create(:media) }

    let(:payload) do
      {
        data: {
          id: media.id.to_s,
          type: 'medias',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(MediaResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { media.reload.attributes }
    end
  end
end
