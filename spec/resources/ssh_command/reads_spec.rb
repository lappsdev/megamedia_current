require 'rails_helper'

RSpec.describe SshCommandResource, type: :resource do
  describe 'serialization' do
    let!(:ssh_command) { create(:ssh_command) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(ssh_command.id)
      expect(data.jsonapi_type).to eq('ssh_commands')
    end
  end

  describe 'filtering' do
    let!(:ssh_command1) { create(:ssh_command) }
    let!(:ssh_command2) { create(:ssh_command) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: ssh_command2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([ssh_command2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:ssh_command1) { create(:ssh_command) }
      let!(:ssh_command2) { create(:ssh_command) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            ssh_command1.id,
            ssh_command2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            ssh_command2.id,
            ssh_command1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
