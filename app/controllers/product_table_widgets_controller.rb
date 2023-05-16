class ProductTableWidgetsController < ApplicationController
  def index
    product_table_widgets = ProductTableWidgetResource.all(params)
    respond_with(product_table_widgets)
  end

  def show
    product_table_widget = ProductTableWidgetResource.find(params)
    respond_with(product_table_widget)
  end

  def create
    product_table_widget = ProductTableWidgetResource.build(params)

    if product_table_widget.save
      render jsonapi: product_table_widget, status: 201
    else
      render jsonapi_errors: product_table_widget
    end
  end

  def update
    product_table_widget = ProductTableWidgetResource.find(params)

    if product_table_widget.update_attributes
      render jsonapi: product_table_widget
    else
      render jsonapi_errors: product_table_widget
    end
  end

  def destroy
    product_table_widget = ProductTableWidgetResource.find(params)

    if product_table_widget.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: product_table_widget
    end
  end
end
