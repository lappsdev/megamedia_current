require 'rails_helper'

RSpec.describe "queue_caller_widgets#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/queue_caller_widgets/#{queue_caller_widget.id}"
  end

  describe 'basic destroy' do
    let!(:queue_caller_widget) { create(:queue_caller_widget) }

    it 'updates the resource' do
      expect(QueueCallerWidgetResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { QueueCallerWidget.count }.by(-1)
      expect { queue_caller_widget.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
