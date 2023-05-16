require 'rails_helper'

RSpec.describe "video_widgets#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/video_widgets", params: params
  end

  describe 'basic fetch' do
    let!(:video_widget1) { create(:video_widget) }
    let!(:video_widget2) { create(:video_widget) }

    it 'works' do
      expect(VideoWidgetResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['video_widgets'])
      expect(d.map(&:id)).to match_array([video_widget1.id, video_widget2.id])
    end
  end
end
