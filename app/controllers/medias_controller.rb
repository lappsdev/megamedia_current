class MediasController < ApplicationController
  def index
    medias = MediaResource.all(params)
    respond_with(medias)
  end

  def show
    media = MediaResource.find(params)
    respond_with(media)
  end

  def create
    media = MediaResource.build(params)

    if media.save
      render jsonapi: media, status: 201
    else
      render jsonapi_errors: media
    end
  end

  def update
    media = MediaResource.find(params)

    if media.update_attributes
      render jsonapi: media
    else
      render jsonapi_errors: media
    end
  end

  def destroy
    media = MediaResource.find(params)

    if media.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: media
    end
  end
end
