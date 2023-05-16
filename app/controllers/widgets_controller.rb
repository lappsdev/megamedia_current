class WidgetsController < ApplicationController
  def index
    widgets = WidgetResource.all(params)
    respond_with(widgets)
  end

  def show
    widget = WidgetResource.find(params)
    respond_with(widget)
  end

  def create
    widget = WidgetResource.build(params)

    if widget.save
      render jsonapi: widget, status: 201
    else
      render jsonapi_errors: widget
    end
  end

  def update
    widget = WidgetResource.find(params)

    if widget.update_attributes
      render jsonapi: widget
    else
      render jsonapi_errors: widget
    end
  end

  def destroy
    widget = WidgetResource.find(params)

    if widget.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: widget
    end
  end
end
