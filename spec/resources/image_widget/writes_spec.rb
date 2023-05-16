require 'rails_helper'

RSpec.describe ImageWidgetResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'image_widgets',
          attributes: attributes_for(:image_widget)
        }
      }
    end

    let(:instance) do
      ImageWidgetResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { ImageWidget.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:image_widget) { create(:image_widget) }

    let(:payload) do
      {
        data: {
          id: image_widget.id.to_s,
          type: 'image_widgets',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      ImageWidgetResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { image_widget.reload.updated_at }
      # .and change { image_widget.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:image_widget) { create(:image_widget) }

    let(:instance) do
      ImageWidgetResource.find(id: image_widget.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { ImageWidget.count }.by(-1)
    end
  end
end
