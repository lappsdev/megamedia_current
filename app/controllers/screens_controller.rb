class ScreensController < ApplicationController
  def index
    screens = ScreenResource.all(params)
    respond_with(screens)
  end

  def show
    screen = ScreenResource.find(params)
    respond_with(screen)
  end

  def create
    screen = ScreenResource.build(params)

    if screen.save
      render jsonapi: screen, status: 201
    else
      render jsonapi_errors: screen
    end
  end

  def update
    screen = ScreenResource.find(params)

    if screen.update_attributes
      render jsonapi: screen
    else
      render jsonapi_errors: screen
    end
  end

  def destroy
    screen = ScreenResource.find(params)

    if screen.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: screen
    end
  end
end
