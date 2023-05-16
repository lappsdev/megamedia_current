require 'rails_helper'

RSpec.describe "widgets#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/widgets/#{widget.id}"
  end

  describe 'basic destroy' do
    let!(:widget) { create(:widget) }

    it 'updates the resource' do
      expect(WidgetResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Widget.count }.by(-1)
      expect { widget.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
