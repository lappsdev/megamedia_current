require 'rails_helper'

RSpec.describe ProductTableWidgetResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'product_table_widgets',
          attributes: attributes_for(:product_table_widget)
        }
      }
    end

    let(:instance) do
      ProductTableWidgetResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { ProductTableWidget.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:product_table_widget) { create(:product_table_widget) }

    let(:payload) do
      {
        data: {
          id: product_table_widget.id.to_s,
          type: 'product_table_widgets',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      ProductTableWidgetResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { product_table_widget.reload.updated_at }
      # .and change { product_table_widget.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:product_table_widget) { create(:product_table_widget) }

    let(:instance) do
      ProductTableWidgetResource.find(id: product_table_widget.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { ProductTableWidget.count }.by(-1)
    end
  end
end
