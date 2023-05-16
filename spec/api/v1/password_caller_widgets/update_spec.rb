require 'rails_helper'

RSpec.describe "password_caller_widgets#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/password_caller_widgets/#{password_caller_widget.id}", payload
  end

  describe 'basic update' do
    let!(:password_caller_widget) { create(:password_caller_widget) }

    let(:payload) do
      {
        data: {
          id: password_caller_widget.id.to_s,
          type: 'password_caller_widgets',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(PasswordCallerWidgetResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { password_caller_widget.reload.attributes }
    end
  end
end
