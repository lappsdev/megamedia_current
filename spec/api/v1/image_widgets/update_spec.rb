require 'rails_helper'

RSpec.describe "image_widgets#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/image_widgets/#{image_widget.id}", payload
  end

  describe 'basic update' do
    let!(:image_widget) { create(:image_widget) }

    let(:payload) do
      {
        data: {
          id: image_widget.id.to_s,
          type: 'image_widgets',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(ImageWidgetResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { image_widget.reload.attributes }
    end
  end
end
