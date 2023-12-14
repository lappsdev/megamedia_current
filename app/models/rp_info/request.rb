class RpInfo::Request
  def self.post(path, params, token: nil, use_ssl: false)
    uri = URI(path)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: use_ssl, read_timeout: 5,
                                                   open_timeout: 5) do |http|
      request = Net::HTTP::Post.new(uri.to_s)
      request['Content-Type'] = 'application/json'
      request['token'] = token if token

      request.body = params.to_json
      http.request request
    end
    JSON.parse(response.body)
  end

  def self.get(path, params = {}, token: nil, use_ssl: false)
    uri = URI(path_with_params(path, params))
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: use_ssl, read_timeout: 5,
                                                   open_timeout: 5) do |http|
      request = Net::HTTP::Get.new(uri.to_s)
      request['Content-Type'] = 'application/json'

      request['token'] = token if token

      http.request request
    end
    JSON.parse(response.body)
  end

  def self.path_with_params(page, params)
    return page if params.empty?

    page + '?' + params.map { |k, v| CGI.escape(k.to_s) + '=' + CGI.escape(v.to_s) }.join('&')
  end
end
