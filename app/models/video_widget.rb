class VideoWidget < Widget
  has_one :media, as: :attachable, dependent: :destroy
  has_one :attachment, through: :media
end
