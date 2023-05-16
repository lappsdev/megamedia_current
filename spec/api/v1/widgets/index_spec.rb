require 'rails_helper'

RSpec.describe "widgets#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/widgets", params: params
  end

  describe 'basic fetch' do
    let!(:widget1) { create(:widget) }
    let!(:widget2) { create(:widget) }

    it 'works' do
      expect(WidgetResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['widgets'])
      expect(d.map(&:id)).to match_array([widget1.id, widget2.id])
    end
  end
end
