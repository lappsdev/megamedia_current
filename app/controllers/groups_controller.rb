class GroupsController < ApplicationController
  def index
    groups = GroupResource.all(params)
    respond_with(groups)
  end

  def show
    group = GroupResource.find(params)
    respond_with(group)
  end

  def create
    group = GroupResource.build(params)

    if group.save
      render jsonapi: group, status: 201
    else
      render jsonapi_errors: group
    end
  end

  def update
    group = GroupResource.find(params)

    if group.update_attributes
      render jsonapi: group
    else
      render jsonapi_errors: group
    end
  end

  def destroy
    group = GroupResource.find(params)

    if group.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: group
    end
  end
end
