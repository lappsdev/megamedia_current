require 'rails_helper'

RSpec.describe "password_caller_widgets#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/password_caller_widgets", params: params
  end

  describe 'basic fetch' do
    let!(:password_caller_widget1) { create(:password_caller_widget) }
    let!(:password_caller_widget2) { create(:password_caller_widget) }

    it 'works' do
      expect(PasswordCallerWidgetResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['password_caller_widgets'])
      expect(d.map(&:id)).to match_array([password_caller_widget1.id, password_caller_widget2.id])
    end
  end
end
