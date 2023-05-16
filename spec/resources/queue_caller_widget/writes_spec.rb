require 'rails_helper'

RSpec.describe QueueCallerWidgetResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'queue_caller_widgets',
          attributes: attributes_for(:queue_caller_widget)
        }
      }
    end

    let(:instance) do
      QueueCallerWidgetResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { QueueCallerWidget.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:queue_caller_widget) { create(:queue_caller_widget) }

    let(:payload) do
      {
        data: {
          id: queue_caller_widget.id.to_s,
          type: 'queue_caller_widgets',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      QueueCallerWidgetResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { queue_caller_widget.reload.updated_at }
      # .and change { queue_caller_widget.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:queue_caller_widget) { create(:queue_caller_widget) }

    let(:instance) do
      QueueCallerWidgetResource.find(id: queue_caller_widget.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { QueueCallerWidget.count }.by(-1)
    end
  end
end
