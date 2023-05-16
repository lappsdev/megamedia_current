require 'rails_helper'

RSpec.describe "image_widgets#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/image_widgets/#{image_widget.id}", params: params
  end

  describe 'basic fetch' do
    let!(:image_widget) { create(:image_widget) }

    it 'works' do
      expect(ImageWidgetResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('image_widgets')
      expect(d.id).to eq(image_widget.id)
    end
  end
end
