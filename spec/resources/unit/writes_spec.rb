require 'rails_helper'

RSpec.describe UnitResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'units',
          attributes: attributes_for(:unit)
        }
      }
    end

    let(:instance) do
      UnitResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Unit.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:unit) { create(:unit) }

    let(:payload) do
      {
        data: {
          id: unit.id.to_s,
          type: 'units',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      UnitResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { unit.reload.updated_at }
      # .and change { unit.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:unit) { create(:unit) }

    let(:instance) do
      UnitResource.find(id: unit.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Unit.count }.by(-1)
    end
  end
end
