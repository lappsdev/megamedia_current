require 'rails_helper'

RSpec.describe MediaResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'medias',
          attributes: attributes_for(:media)
        }
      }
    end

    let(:instance) do
      MediaResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Media.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:media) { create(:media) }

    let(:payload) do
      {
        data: {
          id: media.id.to_s,
          type: 'medias',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      MediaResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { media.reload.updated_at }
      # .and change { media.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:media) { create(:media) }

    let(:instance) do
      MediaResource.find(id: media.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Media.count }.by(-1)
    end
  end
end
