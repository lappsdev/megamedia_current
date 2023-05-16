require 'rails_helper'

RSpec.describe VideoWidgetResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'video_widgets',
          attributes: attributes_for(:video_widget)
        }
      }
    end

    let(:instance) do
      VideoWidgetResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { VideoWidget.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:video_widget) { create(:video_widget) }

    let(:payload) do
      {
        data: {
          id: video_widget.id.to_s,
          type: 'video_widgets',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      VideoWidgetResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { video_widget.reload.updated_at }
      # .and change { video_widget.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:video_widget) { create(:video_widget) }

    let(:instance) do
      VideoWidgetResource.find(id: video_widget.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { VideoWidget.count }.by(-1)
    end
  end
end
