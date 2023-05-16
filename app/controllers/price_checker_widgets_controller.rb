class PriceCheckerWidgetsController < ApplicationController
  def index
    price_checker_widgets = PriceCheckerWidgetResource.all(params)
    respond_with(price_checker_widgets)
  end

  def show
    price_checker_widget = PriceCheckerWidgetResource.find(params)
    respond_with(price_checker_widget)
  end

  def create
    price_checker_widget = PriceCheckerWidgetResource.build(params)

    if price_checker_widget.save
      render jsonapi: price_checker_widget, status: 201
    else
      render jsonapi_errors: price_checker_widget
    end
  end

  def update
    price_checker_widget = PriceCheckerWidgetResource.find(params)

    if price_checker_widget.update_attributes
      render jsonapi: price_checker_widget
    else
      render jsonapi_errors: price_checker_widget
    end
  end

  def destroy
    price_checker_widget = PriceCheckerWidgetResource.find(params)

    if price_checker_widget.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: price_checker_widget
    end
  end
end
