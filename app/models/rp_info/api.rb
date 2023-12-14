class RpInfo::Api
  include ActiveModel::Model
  attr_accessor :unit

  def get_product_by_barcode(barcode)
    url = "#{base_url}/v2.8/produtounidade/#{barcode}/unidade/#{unit.cnpj}/detalhado/consultarcodigobarras"
    token = authenticate
    response = RpInfo::Request.get(url, token: token)
    p response
    if response['response']['status'] == 'ok'
      product = Product.new(description: response['response']['produto']['Descricao'],
                            price: response['response']['produto']['PrecoPDV'],
                            promotional_price: response['response']['produto']['PrecoVenda2'],
                            fator_promotional_price: response['response']['produto']['PrecoPDV3'],
                            fator_promotional: response['response']['produto']['FatorPr3'])
      # FAAALA DERICK
    else
      # RANQUEIOOO
    end
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
