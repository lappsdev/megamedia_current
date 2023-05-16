require 'rails_helper'

RSpec.describe "video_widgets#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/video_widgets/#{video_widget.id}", params: params
  end

  describe 'basic fetch' do
    let!(:video_widget) { create(:video_widget) }

    it 'works' do
      expect(VideoWidgetResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('video_widgets')
      expect(d.id).to eq(video_widget.id)
    end
  end
end
