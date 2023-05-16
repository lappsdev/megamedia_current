require 'rails_helper'

RSpec.describe "ssh_commands#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/ssh_commands/#{ssh_command.id}"
  end

  describe 'basic destroy' do
    let!(:ssh_command) { create(:ssh_command) }

    it 'updates the resource' do
      expect(SshCommandResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { SshCommand.count }.by(-1)
      expect { ssh_command.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
