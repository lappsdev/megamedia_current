class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]

  def index
    groups = GroupResource.all(params)
    respond_with(groups)
  end

  def show
    respond_to do |format|
      format.html
      format.jsonapi do
        group = GroupResource.find(params)
        respond_with(group)
      end
    end
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
    respond_to do |format|
      format.html do
        if @group.update(group_params)
          redirect_to group_url(@group), notice: 'Grupo atualizado com sucesso.'
        else
          render :show, status: :unprocessable_entity
        end
      end
      format.jsonapi do
        group = GroupResource.find(params)

        if group.update_attributes
          render jsonapi: group
        else
          render jsonapi_errors: group
        end
      end
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

  private

  def group_params
    params.require(:group).permit!
  end

  def set_group
    @group = policy_scope(Group).find(params[:id])
  end
end
