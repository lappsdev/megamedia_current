require 'rails_helper'

RSpec.describe "password_caller_widgets#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/password_caller_widgets/#{password_caller_widget.id}", params: params
  end

  describe 'basic fetch' do
    let!(:password_caller_widget) { create(:password_caller_widget) }

    it 'works' do
      expect(PasswordCallerWidgetResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('password_caller_widgets')
      expect(d.id).to eq(password_caller_widget.id)
    end
  end
end
