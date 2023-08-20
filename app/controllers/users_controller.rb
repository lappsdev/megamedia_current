class UsersController < ApplicationController
  before_action :set_user, except: %i[index new create]

  def index
    respond_to do |format|
      format.html do
        @users ||= Current.user.group.users
      end
      format.jsonapi do
        users = UserResource.all(params)
        respond_with(users)
      end
    end
  end

  def new
    @user = Current.user.group.users.build
  end

  def show
    @modalStayOpened = false
    respond_to do |format|
      format.html do
      end
      format.jsonapi do
        user = UserResource.find(params)
        respond_with(user)
      end
    end
  end

  def create
    respond_to do |format|
      format.html do
        @user = Current.user.group.users.build(user_params)

        if @user.save
          redirect_to user_url(@user),
                      notice: 'Usuário cadastrado com sucesso.'
        else
          flash.now[:alert] = 'Erro ao cadastrar!'
          render :new, status: :unprocessable_entity
        end
      end

      format.jsonapi do
        user = UserResource.build(params)

        if user.save
          render jsonapi: user, status: 201
        else
          render jsonapi_errors: user
        end
      end
    end
  end

  def update
    respond_to do |format|
      format.html do
        if @user.update(user_params)
          redirect_to user_url(@user), notice: 'Atualizado com sucesso!'
        else
          flash.now[:alert] = 'Erro ao atualizar dados!'
          @modalStayOpened = true

          render :show, status: :unprocessable_entity
        end
      end
      format.jsonapi do
        user = UserResource.find(params)

        if user.update_attributes
          render jsonapi: user
        else
          render jsonapi_errors: user
        end
      end
    end
  end

  def destroy
    user = UserResource.find(params)

    if user.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: user
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit!
  end
end
