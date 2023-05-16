require 'rails_helper'

RSpec.describe "queue_caller_widgets#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/queue_caller_widgets", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:queue_caller_widget)
    end
    let(:payload) do
      {
        data: {
          type: 'queue_caller_widgets',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(QueueCallerWidgetResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { QueueCallerWidget.count }.by(1)
    end
  end
end
