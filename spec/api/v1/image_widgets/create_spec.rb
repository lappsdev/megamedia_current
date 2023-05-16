require 'rails_helper'

RSpec.describe "image_widgets#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/image_widgets", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:image_widget)
    end
    let(:payload) do
      {
        data: {
          type: 'image_widgets',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(ImageWidgetResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { ImageWidget.count }.by(1)
    end
  end
end
