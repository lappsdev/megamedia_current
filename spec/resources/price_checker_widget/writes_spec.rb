require 'rails_helper'

RSpec.describe PriceCheckerWidgetResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'price_checker_widgets',
          attributes: attributes_for(:price_checker_widget)
        }
      }
    end

    let(:instance) do
      PriceCheckerWidgetResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { PriceCheckerWidget.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:price_checker_widget) { create(:price_checker_widget) }

    let(:payload) do
      {
        data: {
          id: price_checker_widget.id.to_s,
          type: 'price_checker_widgets',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      PriceCheckerWidgetResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { price_checker_widget.reload.updated_at }
      # .and change { price_checker_widget.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:price_checker_widget) { create(:price_checker_widget) }

    let(:instance) do
      PriceCheckerWidgetResource.find(id: price_checker_widget.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { PriceCheckerWidget.count }.by(-1)
    end
  end
end
