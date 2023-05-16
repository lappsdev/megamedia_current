require 'rails_helper'

RSpec.describe "ssh_commands#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/ssh_commands/#{ssh_command.id}", params: params
  end

  describe 'basic fetch' do
    let!(:ssh_command) { create(:ssh_command) }

    it 'works' do
      expect(SshCommandResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('ssh_commands')
      expect(d.id).to eq(ssh_command.id)
    end
  end
end
