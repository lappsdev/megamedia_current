class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[new create]

  before_action :set_session, only: :destroy

  def index
    @sessions = Current.user.sessions.order(created_at: :desc)
  end

  def new; end

  def create
    user = User.find_by(login: params[:login])

    if user && user.authenticate(params[:password])
      @session = user.sessions.create!
      cookies.signed.permanent[:session_token] = { value: @session.id, httponly: true }

      redirect_to root_path, notice: 'Sessão iniciada com sucesso'
    else
      redirect_to sign_in_path(login_hint: params[:login]), alert: 'Login ou senha incorretos.'
    end
  end

  def destroy
    @session.destroy
    redirect_to(sessions_path, notice: 'Sessão encerrada com sucesso')
  end

  private

  def set_session
    @session = Current.user.sessions.find(params[:id])
  end
end
