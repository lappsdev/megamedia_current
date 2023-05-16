class ImageWidgetsController < ApplicationController
  def index
    image_widgets = ImageWidgetResource.all(params)
    respond_with(image_widgets)
  end

  def show
    image_widget = ImageWidgetResource.find(params)
    respond_with(image_widget)
  end

  def create
    image_widget = ImageWidgetResource.build(params)

    if image_widget.save
      render jsonapi: image_widget, status: 201
    else
      render jsonapi_errors: image_widget
    end
  end

  def update
    image_widget = ImageWidgetResource.find(params)

    if image_widget.update_attributes
      render jsonapi: image_widget
    else
      render jsonapi_errors: image_widget
    end
  end

  def destroy
    image_widget = ImageWidgetResource.find(params)

    if image_widget.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: image_widget
    end
  end
end
