class RpInfo::Api
  include ActiveModel::Model
  attr_accessor :unit

  def get_product_by_barcode(barcode)
    url = "#{base_url}/v2.8/produtounidade/#{barcode}/unidade/#{unit.cnpj}/detalhado/consultarcodigobarras"
  end

  def authenticate
    url = "#{base_url}/v1.1/auth"
    usuario = group.rp_info_api_user
    senha = group.rp_info_api_password
    response = RpInfo::Request.post(url, { usuario: usuario, senha: senha })
    raise response['response']['messages'][0]['message'] unless response['response']['status'] == 'ok'

    response['response']['token']
  end

  private

  def group
    unit.group
  end

  def base_url
    "http://#{group.rp_info_api_endpoint}"
  end
end
