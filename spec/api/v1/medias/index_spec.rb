require 'rails_helper'

RSpec.describe "medias#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/medias", params: params
  end

  describe 'basic fetch' do
    let!(:media1) { create(:media) }
    let!(:media2) { create(:media) }

    it 'works' do
      expect(MediaResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['medias'])
      expect(d.map(&:id)).to match_array([media1.id, media2.id])
    end
  end
end
