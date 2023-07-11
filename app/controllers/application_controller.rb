class ApplicationController < ActionController::Base
  include Graphiti::Rails
  include Graphiti::Responders
  skip_before_action :verify_authenticity_token
  before_action :set_current_request_details
  before_action :authenticate
  before_action :determine_format

  private
    def authenticate
      if session_record = Session.find_by_id(cookies.signed[:session_token])
        Current.session = session_record
        credential = Credential.create({login: Current.session.user.login, password: "teste123123"}).tap do |c|
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
      request.format = :jsonapi if (request.format == 'application/vnd.api+json')
    end

  
end
