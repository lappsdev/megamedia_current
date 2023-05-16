require 'rails_helper'

RSpec.describe "video_widgets#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/video_widgets/#{video_widget.id}", payload
  end

  describe 'basic update' do
    let!(:video_widget) { create(:video_widget) }

    let(:payload) do
      {
        data: {
          id: video_widget.id.to_s,
          type: 'video_widgets',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(VideoWidgetResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { video_widget.reload.attributes }
    end
  end
end
