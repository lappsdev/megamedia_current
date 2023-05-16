module AttachableResource
  extend ActiveSupport::Concern
  included do
    polymorphic_has_one :media, as: :attachable

    polymorphic_has_one :attachment, as: :attachable, resource: AttachmentResource do
      pre_load do |proxy, _attachments|
        proxy.scope.object = proxy.scope.object.eager_load(:medias)
      end
      assign do |_widget, attachments|
        attachments.first
      end
    end
    
  end
  def disassociate(parent, child, association_name, type)
    if association_name == :attachment
      parent.media.destroy
    else
      super
    end
  end
end
