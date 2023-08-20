class DepartmentsController < ApplicationController
  before_action :get_unit
  before_action :set_department, only: %i[show edit update destroy]

  # GET /departments or /departments.json
  def index
    respond_to do |format|
      format.html do
        @departments = @unit&.departments || Department.all
      end
      format.jsonapi do
        departments = DepartmentResource.all(params)
        respond_with(departments)
      end
    end
  end

  # GET /departments/1 or /departments/1.json
  def show; end

  # GET /departments/new
  def new
    @department = @unit&.departments&.build || Department.new
  end

  # GET /departments/1/edit
  def edit; end

  # POST /departments or /departments.json
  def create
    @department = @unit&.departments&.build(department_params) || Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.html do
          redirect_to unit_url(@unit || @department.unit),
                      notice: 'Departamento cadastrado com sucesso.'
        end
        format.json { render :show, status: :created, location: @department }
      else
        format.html do
          flash.now[:alert] = 'Erro ao cadastrar!'
          render :new, status: :unprocessable_entity
        end
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1 or /departments/1.json
  def update
    respond_to do |format|
      format.jsonapi do
        department = DepartmentResource.find(params)

        if department.update_attributes
          render jsonapi: department
        else
          render jsonapi_errors: department
        end
      end
      format.html do
        if @department.update(department_params)
          redirect_to department_url(@department), notice: 'Departamento atualizado com sucesso.'
        else
          render :edit, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /departments/1 or /departments/1.json
  def destroy
    @department.destroy

    respond_to do |format|
      format.html { redirect_to unit_path(@department.unit), notice: 'Departamento excluído.' }
      format.json { head :no_content }
    end
  end

  private

  def get_unit
    @unit = Unit.find_by_id(params[:unit_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_department
    @department = Department.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def department_params
    params.require(:department).permit(:name, :unit_id)
  end
end
