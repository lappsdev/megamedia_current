class PasswordCallerWidgetsController < ApplicationController
  def index
    password_caller_widgets = PasswordCallerWidgetResource.all(params)
    respond_with(password_caller_widgets)
  end

  def show
    password_caller_widget = PasswordCallerWidgetResource.find(params)
    respond_with(password_caller_widget)
  end

  def create
    password_caller_widget = PasswordCallerWidgetResource.build(params)

    if password_caller_widget.save
      render jsonapi: password_caller_widget, status: 201
    else
      render jsonapi_errors: password_caller_widget
    end
  end

  def update
    password_caller_widget = PasswordCallerWidgetResource.find(params)

    if password_caller_widget.update_attributes
      render jsonapi: password_caller_widget
    else
      render jsonapi_errors: password_caller_widget
    end
  end

  def destroy
    password_caller_widget = PasswordCallerWidgetResource.find(params)

    if password_caller_widget.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: password_caller_widget
    end
  end
end
