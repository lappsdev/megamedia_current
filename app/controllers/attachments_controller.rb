class AttachmentsController < ApplicationController
  before_action :set_attachment, except: %i[index new create]
  def index
    respond_to do |format|
      format.html { @attachments = Current.user.group.attachments.order(created_at: :desc) }
      format.jsonapi  do
        attachments = AttachmentResource.all(params)
        respond_with(attachments)
      end
    end
  end

  def show
    respond_to do |format|
      format.html { @attachment = Attachment.find(params[:id]) }
      format.jsonapi do
        attachment = AttachmentResource.find(params)
        respond_with(attachment)
      end
    end
  end

  def create
    attachment = Attachment.new(attachment_params)
    attachment.group = Current.user.group
    if attachment.save
      respond_to do |format|
        format.html { redirect_to attachments_url, notice: 'Upload de mídia realizado com sucesso!' }
        format.jsonapi { render json: attachment, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :index, status: :unprocessable_entity, alert: 'Falha ao realizar upload' }
        format.jsonapi { render json: attachment, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      format.html do
        if @attachment.update(attachment_params)
          redirect_to attachment_url(@attachment), notice: 'Mídia atualizada com sucesso!'
        end
      end
      format.jsonapi do
        attachment = AttachmentResource.find(params)

        if attachment.update_attributes
          render jsonapi: attachment
        else
          render jsonapi_errors: attachment
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      format.html do
        if @attachment.destroy
          redirect_to attachments_url, notice: 'Mídia excluída com sucesso!'
        else
          render :show, status: :unprocessable_entity
        end
      end

      format.jsonapi do
        attachment = AttachmentResource.find(params)

        if attachment.destroy
          render jsonapi: { meta: {} }, status: 200
        else
          render jsonapi_errors: attachment
        end
      end
    end
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

  def attachment_params
    params.require(:attachment).permit!
          .tap { |param| param[:weekdays] = [].tap { |a| param[:weekdays].each { |k, v| a[k.to_i] = v } } }
  end
end
