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
  has_many :attachables, through: :medias
  delegate :image?, to: :file
  delegate :video?, to: :file
  after_create_commit :process_video
  attr_accessor :attachable_id, :attachable_type

  before_save :set_attach_type
  before_create :set_name
  scope :expired, -> { where('expired_at < ?', Time.now) }

  def set_attach_type
    if file.image?
      self.attach_type = 'image'
    elsif file.video?
      self.attach_type = 'video'
    end
  end

  def expired?
    return true unless weekdays[Time.now.wday]

    if schedule_started_at && schedule_finished_at
      !Time.now.between?(schedule_started_at.beginning_of_day, schedule_finished_at.end_of_day)
    elsif schedule_started_at && !schedule_finished_at
      !Time.now.after?(schedule_started_at.beginning_of_day)
    elsif !schedule_started_at && schedule_finished_at
      !Time.now.before?(schedule_finished_at.beginning_of_day)
    else
      false
    end
  end

  def attached_in
    medias.map { |media| media.attachable }
  end

  def process_video
    ConvertVideoAttachmentWorker.perform_async(id) if file.attached? && file.video?
  end

  private

  def set_name
    self.name ||= file.filename.to_s
  end
end
