require 'rails_helper'

RSpec.describe SshCommandResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'ssh_commands',
          attributes: attributes_for(:ssh_command)
        }
      }
    end

    let(:instance) do
      SshCommandResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { SshCommand.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:ssh_command) { create(:ssh_command) }

    let(:payload) do
      {
        data: {
          id: ssh_command.id.to_s,
          type: 'ssh_commands',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      SshCommandResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { ssh_command.reload.updated_at }
      # .and change { ssh_command.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:ssh_command) { create(:ssh_command) }

    let(:instance) do
      SshCommandResource.find(id: ssh_command.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { SshCommand.count }.by(-1)
    end
  end
end
