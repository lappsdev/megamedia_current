require 'rails_helper'

RSpec.describe "widgets#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/widgets/#{widget.id}", payload
  end

  describe 'basic update' do
    let!(:widget) { create(:widget) }

    let(:payload) do
      {
        data: {
          id: widget.id.to_s,
          type: 'widgets',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(WidgetResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { widget.reload.attributes }
    end
  end
end
