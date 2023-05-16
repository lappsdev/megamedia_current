class AttachmentsController < ApplicationController
  def index
    attachments = AttachmentResource.all(params)
    respond_with(attachments)
  end

  def show
    attachment = AttachmentResource.find(params)
    respond_with(attachment)
  end

  def create
    attachment = Attachment.new(params.require(:attachment).permit(:file))
    attachment.group = current_user.group
    if attachment.save
      render json: attachment, status: :created
    else
      render json: attachment, status: :unprocessable_entity
    end
  end

  def update
    attachment = AttachmentResource.find(params)

    if attachment.update_attributes
      render jsonapi: attachment
    else
      render jsonapi_errors: attachment
    end
  end

  def destroy
    attachment = AttachmentResource.find(params)

    if attachment.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: attachment
    end
  end
end
