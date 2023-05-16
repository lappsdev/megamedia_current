require 'rails_helper'

RSpec.describe "image_widgets#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/image_widgets/#{image_widget.id}"
  end

  describe 'basic destroy' do
    let!(:image_widget) { create(:image_widget) }

    it 'updates the resource' do
      expect(ImageWidgetResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { ImageWidget.count }.by(-1)
      expect { image_widget.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
