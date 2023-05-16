require 'rails_helper'

RSpec.describe "ssh_commands#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/ssh_commands/#{ssh_command.id}", payload
  end

  describe 'basic update' do
    let!(:ssh_command) { create(:ssh_command) }

    let(:payload) do
      {
        data: {
          id: ssh_command.id.to_s,
          type: 'ssh_commands',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(SshCommandResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { ssh_command.reload.attributes }
    end
  end
end
