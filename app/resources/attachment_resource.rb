class AttachmentResource < ApplicationResource
  include Rails.application.routes.url_helpers
  belongs_to :group
  has_many :medias
  has_one :scheduler
  attribute :name, :string
  attribute :description, :string
  attribute :attach_type, :string_enum, allow: Attachment.attach_types.keys
  attribute :expired_at, :datetime
  attribute :expired, :boolean do
    @object.expired?
  end
  attribute :file, :string do
    attachment = @object.send(:file)
    attachment.attached? ? rails_blob_path(attachment, only_path: true) : ''
  end

  filter :group_id, :integer
  filter :attachable_id, :integer, only: [:eq, :eql] do
    eq do |scope, value|
      scope
        .includes(:medias)
        .where(medias: { attachable_id: value })
    end
    eql do |scope, value|
      scope
        .includes(:medias)
        .where(medias: { attachable_id: value })
    end
  end
  filter :attachable_type, :string, only: [:eq, :eql] do
    eq do |scope, value|
      scope
        .includes(:medias)
        .where(medias: { attachable_type: value })
    end
    eql do |scope, value|
      scope
        .includes(:medias)
        .where(medias: { attachable_id: value })
    end
  end

  def assign_attributes(model_instance, attributes)
    attachments = extract_attachments(attributes)
    attach_data(model_instance, attachments)

    attributes.each_pair { |key, value| model_instance.send(:"#{key}=", value) }
  end

  def save(model)
    super.tap do |model|
      if model.attachable_id && model.attachable_type
        model.medias.create!(attachable_id: model.attachable_id, attachable_type: model.attachable_type)
      end
    end
  end

  private

  def attach_data(model_instance, attachments)
    attachments.each do |attribute, data|
      ## Active Storage
      model_instance.send(:"#{attribute}").attach(data: data)
    end
  end

  def extract_attachments(attrs)
    attachments = {}
    attachment = attrs.delete(:file)
    attachments[:file] = attachment if attachment.present?
    attachments
  end
end
