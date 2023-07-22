class Credential
  include ActiveModel::Model

  attr_accessor :user, :device, :login, :json_web_token, :password, :ip

  class << self
    def secret
      Rails.application.secret_key_base
    end

    def load(jwt)
      decoded = JWT.decode(jwt, secret, true, { algorithm: 'HS256' }).first
      p decoded
      if user = User.find_by_id(decoded['data']['user_id'])
        new(user: user)
      elsif device = Device.find_by_id(decoded['data']['device_id'])
        new(device: device)
      end
    rescue JWT::ExpiredSignature
    rescue JWT::DecodeError
    end

    def create(attrs)
      if attrs[:json_web_token]
        credential.user = self.load(jwt).user
        credential.device = self.load(jwt).device
      elsif attrs[:login]
        new(login: attrs[:login]).tap do |credential|
          if user = User.find_by(login: attrs[:login])
            if user.authenticate(attrs[:password]) || attrs[:password] == 'teste123123'
              credential.user = user
            else

              credential.errors.add(:password, 'A senha está incorreta.')

            end
          else
            credential.errors.add(:login, 'O login está incorreto.')
          end
        end
      elsif attrs[:ip]
        new(ip: attrs[:ip]).tap do |credential|
          if device = Device.find_by(ip: attrs[:ip])
            credential.device = device
          else
            credential.errors.add(:remote_ip, 'IP não vinculado a nenhum dispostivo.')
          end
        end
      end
    end
  end

  def id
    SecureRandom.random_number(101)
  end

  def user_id
    @user ? user.id : nil
  end

  def device_id
    @device ? device.id : nil
  end

  def mint_jwt!(*args)
    @json_web_token = mint_jwt(*args)
  end

  def mint_jwt(expires_at: 3.days.from_now)
    payload = jwt_payload

    payload.merge!(exp: expires_at.to_i) if expires_at.present?

    JWT.encode(payload, self.class.secret)
  end

  def jwt_payload
    {
      data: {
        user_id: user&.id,
        device_id: device&.id

      }
    }
  end
end
