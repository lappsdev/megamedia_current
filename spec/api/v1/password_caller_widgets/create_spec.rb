require 'rails_helper'

RSpec.describe "password_caller_widgets#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/password_caller_widgets", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:password_caller_widget)
    end
    let(:payload) do
      {
        data: {
          type: 'password_caller_widgets',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(PasswordCallerWidgetResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { PasswordCallerWidget.count }.by(1)
    end
  end
end
