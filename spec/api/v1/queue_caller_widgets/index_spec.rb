require 'rails_helper'

RSpec.describe "queue_caller_widgets#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/queue_caller_widgets", params: params
  end

  describe 'basic fetch' do
    let!(:queue_caller_widget1) { create(:queue_caller_widget) }
    let!(:queue_caller_widget2) { create(:queue_caller_widget) }

    it 'works' do
      expect(QueueCallerWidgetResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['queue_caller_widgets'])
      expect(d.map(&:id)).to match_array([queue_caller_widget1.id, queue_caller_widget2.id])
    end
  end
end
