require 'rails_helper'

RSpec.describe GroupResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'groups',
          attributes: attributes_for(:group)
        }
      }
    end

    let(:instance) do
      GroupResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Group.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:group) { create(:group) }

    let(:payload) do
      {
        data: {
          id: group.id.to_s,
          type: 'groups',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      GroupResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { group.reload.updated_at }
      # .and change { group.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:group) { create(:group) }

    let(:instance) do
      GroupResource.find(id: group.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Group.count }.by(-1)
    end
  end
end
