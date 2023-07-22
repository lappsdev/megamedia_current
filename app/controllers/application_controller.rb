class ApplicationController < ActionController::Base
  include Graphiti::Rails
  include Graphiti::Responders
  skip_before_action :verify_authenticity_token
  before_action :set_ip
  before_action :set_current_request_details
  before_action :authenticate
  before_action :determine_format

  private

  def set_ip
    p params[:ip]
    p params
    @ip = params[:ip] || request.headers['X-Forwarded-For'] || request.env['HTTP_X_FORWARDED_FOR'] || request.remote_addr
  end

  def authenticate
    p jwt
    if jwt
      credential = Credential.load(jwt)
      @json_web_token = credential.json_web_token
      Current.device = credential.device
    elsif session_record = Session.find_by_id(cookies.signed[:session_token])
      Current.session = session_record
      credential = Credential.create({ login: Current.session.user.login, password: 'teste123123' }).tap do |c|
        c.mint_jwt! if c.errors.blank?
      end
      @json_web_token = credential.json_web_token
    elsif device = Device.find_by(ip: @ip)
      Current.device = device
      credential = Credential.create({ ip: @ip }).tap do |c|
        c.mint_jwt! if c.errors.blank?
      end
      @json_web_token = credential.json_web_token
    else
      redirect_to sign_in_path
    end
  end

  def set_current_request_details
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
  end

  def determine_format
    request.format = :jsonapi if request.format == 'application/vnd.api+json'
  end

  def user_via_jwt
    invalid_token! unless @credential = Credential.load(jwt)

    @credential.user
  end

  def jwt
    header = request.headers['Authorization']
    if header&.match?(/^Bearer /)
      header.split(/^Bearer /)[1]
    else
      false
    end
  end

  def invalid_token!
    raise Errors::InvalidAuthorizationToken
  end

  def unauthorized!
    raise Errors::NotAuthorized
  end
end
