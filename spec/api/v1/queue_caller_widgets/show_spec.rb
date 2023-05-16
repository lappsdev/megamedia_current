require 'rails_helper'

RSpec.describe "queue_caller_widgets#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/queue_caller_widgets/#{queue_caller_widget.id}", params: params
  end

  describe 'basic fetch' do
    let!(:queue_caller_widget) { create(:queue_caller_widget) }

    it 'works' do
      expect(QueueCallerWidgetResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('queue_caller_widgets')
      expect(d.id).to eq(queue_caller_widget.id)
    end
  end
end
