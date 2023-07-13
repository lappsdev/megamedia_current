class AttachmentsController < ApplicationController
  def index
    respond_to do |format|
      format.html{ @attachments = Current.user.group.attachments.order(created_at: :desc)}
      format.jsonapi{
        attachments = AttachmentResource.all(params)
        respond_with(attachments)
      }
    end

  end

  def show
    respond_to do |format|
      format.html { @attachment = Attachment.find(params[:id]) }
      format.jsonapi{ 
        attachment = AttachmentResource.find(params)
        respond_with(attachment)
      }
    end


  end

  def create
    attachment = Attachment.new(params.require(:attachment).permit(:file))
    attachment.group = Current.user.group
    if attachment.save
      respond_to do |format|
        format.html { redirect_to attachments_url, notice: 'Upload de mídia realizado com sucesso!' }
        format.jsonapi{ render json: attachment, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :index, status: :unprocessable_entity, alert: 'Falha ao realizar upload' }
        format.jsonapi{ render json: attachment, status: :unprocessable_entity }
      end
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
    respond_to do |format|
      format.html { 
        @attachment = Attachment.find(params[:id])
        if @attachment.destroy
          redirect_to attachments_url, notice: 'Mídia excluída com sucesso!' 
        else
          render :show, status: :unprocessable_entity 
        end
      }

      format.jsonapi{  
        attachment = AttachmentResource.find(params)

        if attachment.destroy
          render jsonapi: { meta: {} }, status: 200
        else
          render jsonapi_errors: attachment
        end
      }
    end

   
  end
end
