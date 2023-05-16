class SchedulersController < ApplicationController
  def index
    schedulers = SchedulerResource.all(params)
    respond_with(schedulers)
  end

  def show
    scheduler = SchedulerResource.find(params)
    respond_with(scheduler)
  end

  def create
    scheduler = SchedulerResource.build(params)

    if scheduler.save
      render jsonapi: scheduler, status: 201
    else
      render jsonapi_errors: scheduler
    end
  end

  def update
    scheduler = SchedulerResource.find(params)

    if scheduler.update_attributes
      render jsonapi: scheduler
    else
      render jsonapi_errors: scheduler
    end
  end

  def destroy
    scheduler = SchedulerResource.find(params)

    if scheduler.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: scheduler
    end
  end
end
