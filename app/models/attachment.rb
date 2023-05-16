class Attachment < ApplicationRecord
  include Schedulable
  has_one_attached :file
  enum attach_type: {
    image: 0,
    video: 1
  }
  validates :file, presence: true
  belongs_to :group
  has_many :medias, dependent: :destroy

  delegate :image?, to: :file
  delegate :video?, to: :file
  after_create_commit :process_video
  attr_accessor :attachable_id, :attachable_type

  before_save :set_attach_type

  scope :expired, -> { where('expired_at < ?', Time.now) }
  def expired?
    !!(expired_at && Time.now.after?(expired_at))
  end

  def process_video
    ConvertVideoAttachmentWorker.perform_async(id) if file.attached? && file.video?
  end

  def set_attach_type
    if file.image?
      self.attach_type = 'image'
    elsif file.video?
      self.attach_type = 'video'
    end
  end
end
