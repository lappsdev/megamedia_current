require 'rails_helper'

RSpec.describe "medias#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/medias", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:media)
    end
    let(:payload) do
      {
        data: {
          type: 'medias',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(MediaResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Media.count }.by(1)
    end
  end
end
