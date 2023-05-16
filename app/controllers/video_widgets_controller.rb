class VideoWidgetsController < ApplicationController
  def index
    video_widgets = VideoWidgetResource.all(params)
    respond_with(video_widgets)
  end

  def show
    video_widget = VideoWidgetResource.find(params)
    respond_with(video_widget)
  end

  def create
    video_widget = VideoWidgetResource.build(params)

    if video_widget.save
      render jsonapi: video_widget, status: 201
    else
      render jsonapi_errors: video_widget
    end
  end

  def update
    video_widget = VideoWidgetResource.find(params)

    if video_widget.update_attributes
      render jsonapi: video_widget
    else
      render jsonapi_errors: video_widget
    end
  end

  def destroy
    video_widget = VideoWidgetResource.find(params)

    if video_widget.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: video_widget
    end
  end
end
