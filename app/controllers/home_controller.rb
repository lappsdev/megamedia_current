class HomeController < ApplicationController
  skip_before_action :authenticate

  def index
    ip = request.headers['X-Forwarded-For'] || request.env['HTTP_X_FORWARDED_FOR'] || request.remote_addr
    if Device.find_by(ip: ip)
      Current.device = Device.find_by(ip: ip)
      credential = Credential.create({ip: ip}).tap do |c|
        c.mint_jwt! if c.errors.blank?
      end
      @json_web_token = credential.json_web_token

    else
      redirect_to sign_in_path
    end
  end
end
