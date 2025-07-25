class UnitsController < ApplicationController
  before_action :set_unit, except: %i[index new create]

  def index
    respond_to do |format|
      format.html { @units = policy_scope(Unit) }
      format.jsonapi do
        units = UnitResource.all(params)
        respond_with(units)
      end
    end
  end

  def show
    respond_to do |format|
      format.html { @unit = policy_scope(Unit).find(params[:id]) }
      format.jsonapi do
        unit = UnitResource.find(params)
        respond_with(unit)
      end
    end
  end

  def new
    @unit = Current.user.group.units.build
  end

  def create
    respond_to do |format|
      format.html do
        @unit = Current.user.group.units.build(unit_params)
        if @unit.save
          redirect_to unit_url(@unit), notice: 'Unidade cadastrada com sucesso.'
        else
          flash.now[:alert] = 'Erro ao cadastrar!'
          render :new, status: :unprocessable_entity
        end
      end
      format.jsonapi do
        unit = UnitResource.build(params)

        if unit.save
          render jsonapi: unit, status: 201
        else
          render jsonapi_errors: unit
        end
      end
    end
  end

  def update
    respond_to do |format|
      format.html do
        redirect_to unit_url(@unit), notice: 'Atualizado com sucesso!' if @unit.update(unit_params)
      end
      format.jsonapi do
        unit = UnitResource.find(params)

        if unit.update_attributes
          render jsonapi: unit
        else
          render jsonapi_errors: unit
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      format.html do
        @unit.destroy
        redirect_to units_url, notice: 'Unidade excluída.'
      end
      format.jsonapi do
        unit = UnitResource.find(params)

        if unit.destroy
          render jsonapi: { meta: {} }, status: 200
        else
          render jsonapi_errors: unit
        end
      end
    end
  end

  private

  def unit_params
    params.require(:unit).permit!
  end

  def set_unit
    @unit = policy_scope(Unit).find(params[:id])
  end
end
