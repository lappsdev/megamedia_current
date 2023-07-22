class CredentialsController < ApplicationController
  skip_before_action :authenticate

  def create
    unless params[:data].key?(:attributes) && params[:data][:attributes].key?(:login)
      params[:data][:attributes] = {}
      params[:data][:attributes][:ip] = @ip

    end

    credential = CredentialResource.build(params)

    if credential.save
      render jsonapi: credential, status: 201
    else
      render jsonapi_errors: credential
    end
  end
end
