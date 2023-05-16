require 'rails_helper'

RSpec.describe "queue_caller_widgets#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/queue_caller_widgets/#{queue_caller_widget.id}", payload
  end

  describe 'basic update' do
    let!(:queue_caller_widget) { create(:queue_caller_widget) }

    let(:payload) do
      {
        data: {
          id: queue_caller_widget.id.to_s,
          type: 'queue_caller_widgets',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(QueueCallerWidgetResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { queue_caller_widget.reload.attributes }
    end
  end
end
