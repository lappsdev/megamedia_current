class CredentialResource < ApplicationResource
  self.adapter = Graphiti::Adapters::Null
  self.model = Credential

  attribute :login, :string, only: %i[readable writable]
  attribute :password, :string, only: :writable
  attribute :json_web_token, :string, only: :readable
  attribute :ip, :string, only: :writable
  belongs_to :user
  belongs_to :device

  def create(attrs)
    Credential.create(attrs).tap do |c|
      c.mint_jwt! if c.errors.blank?
    end
  end
end
