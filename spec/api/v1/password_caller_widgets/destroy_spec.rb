require 'rails_helper'

RSpec.describe "password_caller_widgets#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/password_caller_widgets/#{password_caller_widget.id}"
  end

  describe 'basic destroy' do
    let!(:password_caller_widget) { create(:password_caller_widget) }

    it 'updates the resource' do
      expect(PasswordCallerWidgetResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { PasswordCallerWidget.count }.by(-1)
      expect { password_caller_widget.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
