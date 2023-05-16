class MediaResource < ApplicationResource
  belongs_to :attachment
  polymorphic_belongs_to :attachable do
    group_by(:attachable_type) do
      on(:ImageWidget)
      on(:VideoWidget)
    end
  end
  filter :attachment_id, :integer

  filter :attachable_id, :integer
  filter :attachable_type, :string, allow: %w[ImageWidget, VideoWidget]
end
