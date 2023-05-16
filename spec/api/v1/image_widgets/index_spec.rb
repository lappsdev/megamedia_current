require 'rails_helper'

RSpec.describe "image_widgets#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/image_widgets", params: params
  end

  describe 'basic fetch' do
    let!(:image_widget1) { create(:image_widget) }
    let!(:image_widget2) { create(:image_widget) }

    it 'works' do
      expect(ImageWidgetResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['image_widgets'])
      expect(d.map(&:id)).to match_array([image_widget1.id, image_widget2.id])
    end
  end
end
