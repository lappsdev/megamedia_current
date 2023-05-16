require 'rails_helper'

RSpec.describe "ssh_commands#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/ssh_commands", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:ssh_command)
    end
    let(:payload) do
      {
        data: {
          type: 'ssh_commands',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(SshCommandResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { SshCommand.count }.by(1)
    end
  end
end
