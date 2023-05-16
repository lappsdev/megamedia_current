require 'rails_helper'

RSpec.describe "medias#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/medias/#{media.id}", params: params
  end

  describe 'basic fetch' do
    let!(:media) { create(:media) }

    it 'works' do
      expect(MediaResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('medias')
      expect(d.id).to eq(media.id)
    end
  end
end
