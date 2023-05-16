class QueueCallerWidgetsController < ApplicationController
  def index
    queue_caller_widgets = QueueCallerWidgetResource.all(params)
    respond_with(queue_caller_widgets)
  end

  def show
    queue_caller_widget = QueueCallerWidgetResource.find(params)
    respond_with(queue_caller_widget)
  end

  def create
    queue_caller_widget = QueueCallerWidgetResource.build(params)

    if queue_caller_widget.save
      render jsonapi: queue_caller_widget, status: 201
    else
      render jsonapi_errors: queue_caller_widget
    end
  end

  def update
    queue_caller_widget = QueueCallerWidgetResource.find(params)

    if queue_caller_widget.update_attributes
      render jsonapi: queue_caller_widget
    else
      render jsonapi_errors: queue_caller_widget
    end
  end

  def destroy
    queue_caller_widget = QueueCallerWidgetResource.find(params)

    if queue_caller_widget.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: queue_caller_widget
    end
  end
end
