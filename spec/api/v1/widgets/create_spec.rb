require 'rails_helper'

RSpec.describe "widgets#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/widgets", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:widget)
    end
    let(:payload) do
      {
        data: {
          type: 'widgets',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(WidgetResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Widget.count }.by(1)
    end
  end
end
