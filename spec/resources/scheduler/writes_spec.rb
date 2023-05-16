require 'rails_helper'

RSpec.describe SchedulerResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'schedulers',
          attributes: attributes_for(:scheduler)
        }
      }
    end

    let(:instance) do
      SchedulerResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Scheduler.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:scheduler) { create(:scheduler) }

    let(:payload) do
      {
        data: {
          id: scheduler.id.to_s,
          type: 'schedulers',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      SchedulerResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { scheduler.reload.updated_at }
      # .and change { scheduler.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:scheduler) { create(:scheduler) }

    let(:instance) do
      SchedulerResource.find(id: scheduler.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Scheduler.count }.by(-1)
    end
  end
end
