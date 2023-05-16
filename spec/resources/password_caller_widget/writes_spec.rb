require 'rails_helper'

RSpec.describe PasswordCallerWidgetResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'password_caller_widgets',
          attributes: attributes_for(:password_caller_widget)
        }
      }
    end

    let(:instance) do
      PasswordCallerWidgetResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { PasswordCallerWidget.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:password_caller_widget) { create(:password_caller_widget) }

    let(:payload) do
      {
        data: {
          id: password_caller_widget.id.to_s,
          type: 'password_caller_widgets',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      PasswordCallerWidgetResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { password_caller_widget.reload.updated_at }
      # .and change { password_caller_widget.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:password_caller_widget) { create(:password_caller_widget) }

    let(:instance) do
      PasswordCallerWidgetResource.find(id: password_caller_widget.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { PasswordCallerWidget.count }.by(-1)
    end
  end
end
