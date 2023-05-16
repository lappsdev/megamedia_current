require 'rails_helper'

RSpec.describe "ssh_commands#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/ssh_commands", params: params
  end

  describe 'basic fetch' do
    let!(:ssh_command1) { create(:ssh_command) }
    let!(:ssh_command2) { create(:ssh_command) }

    it 'works' do
      expect(SshCommandResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['ssh_commands'])
      expect(d.map(&:id)).to match_array([ssh_command1.id, ssh_command2.id])
    end
  end
end
