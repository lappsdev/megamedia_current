class ApplicationController < ActionController::API
  include Graphiti::Rails
  include Graphiti::Responders
  before_action :authenticate_device
  before_action :authenticate_user, unless: -> { @current_device }
  # skip_before_action :verify_authenticity_token

  register_exception Errors::MissingAuthorizationToken, status: 401, message: true
  register_exception Errors::InvalidAuthorizationToken, status: 401, message: true
  register_exception Errors::NotAuthorized, status: 403, message: true
  register_exception Graphiti::Errors::RecordNotFound, status: 404

  rescue_from Exception do |e|
    handle_exception(e, show_raw_error: Rails.env.test? || Rails.env.development?)
  end

  def authenticate_device
    @current_device ||= device_via_ip
  end

  def authenticate_user
    @current_user ||= user_via_jwt
  end

  def current_device
    if defined? @current_device
      @current_device
    else
      authenticate_device
    end
    @current_device = nil
  end

  def current_user
    if defined? @current_user
      @current_user
    else
      authenticate_user
    end
  rescue Errors::MissingAuthorizationToken
    @current_user = nil
  end

  def device_via_ip
    ip = request.headers['X-Forwarded-For']
    Device.find_by_ip(ip)
  end

  def user_via_jwt
    invalid_token! unless @credential = Credential.load(jwt)

    @credential.user
  end

  def jwt
    header = request.headers['Authorization']
    raise Errors::MissingAuthorizationToken unless header&.match?(/^Bearer /)

    header.split(/^Bearer /)[1]
  end

  def invalid_token!
    raise Errors::InvalidAuthorizationToken
  end

  def unauthorized!
    raise Errors::NotAuthorized
  end
end
