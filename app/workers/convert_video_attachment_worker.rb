class ConvertVideoAttachmentWorker
  include Sidekiq::Worker

  def perform(attachment_id)
    attachment = Attachment.find(attachment_id)
    file = attachment.file
    if file.attached? && file.video?

      orig_video_tmpfile = "#{Rails.root}/tmp/#{file.blob.key}_#{file.blob.filename}"
      mp4_video_tmpfile = "#{Rails.root}/tmp/final_#{file.blob.key}_#{file.blob.filename.base}.mp4"
      File.open(orig_video_tmpfile, 'wb') do |f|
        f.write(file.download)
      end

      system("ffmpeg -i  '#{orig_video_tmpfile}' -vcodec h264 -b:v 1000k -acodec mp2 '#{mp4_video_tmpfile}' ")

      file.attach(
        io: File.open(mp4_video_tmpfile),
        filename: "#{file.blob.filename.base}.mp4",
        content_type: 'video/mp4'
      )

      File.delete(orig_video_tmpfile)
      File.delete(mp4_video_tmpfile)
    end
  end
end
