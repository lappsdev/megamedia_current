require 'rails_helper'

RSpec.describe "video_widgets#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/video_widgets/#{video_widget.id}"
  end

  describe 'basic destroy' do
    let!(:video_widget) { create(:video_widget) }

    it 'updates the resource' do
      expect(VideoWidgetResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { VideoWidget.count }.by(-1)
      expect { video_widget.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
