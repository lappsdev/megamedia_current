require 'rails_helper'

RSpec.describe "widgets#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/widgets/#{widget.id}", params: params
  end

  describe 'basic fetch' do
    let!(:widget) { create(:widget) }

    it 'works' do
      expect(WidgetResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('widgets')
      expect(d.id).to eq(widget.id)
    end
  end
end
