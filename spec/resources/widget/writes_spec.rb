require 'rails_helper'

RSpec.describe WidgetResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'widgets',
          attributes: attributes_for(:widget)
        }
      }
    end

    let(:instance) do
      WidgetResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Widget.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:widget) { create(:widget) }

    let(:payload) do
      {
        data: {
          id: widget.id.to_s,
          type: 'widgets',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      WidgetResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { widget.reload.updated_at }
      # .and change { widget.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:widget) { create(:widget) }

    let(:instance) do
      WidgetResource.find(id: widget.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Widget.count }.by(-1)
    end
  end
end
