class CredentialsController < ApplicationController
  skip_before_action :authenticate

  def create
    if !params[:data]&.key?(:attributes) && !params[:data][:attributes]&.key?(:login) && @uuid.nil?
      params[:data][:attributes] = {}
      params[:data][:attributes][:ip] = @ip
    end
    if jwt
      credential = Credential.load(jwt)
      @json_web_token = jwt
      if credential.device
        Current.device = credential.device
        params[:data][:attributes] = {}
        if @uuid
          params[:data][:attributes][:json_web_token] = jwt

        else
          params[:data][:attributes][:ip] = Current.device.ip

        end
      elsif credential.user
        Current.user = credential.user
        params[:data][:attributes] = {}
        params[:data][:attributes][:json_web_token] = jwt
      end
    end
    credential = CredentialResource.build(params)

    if credential.save
      render jsonapi: credential, status: 201
    else
      render jsonapi_errors: credential
    end
  end
end
