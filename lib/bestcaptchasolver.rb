require 'net/https'
require 'base64'
require 'json'
require 'uri'

# endpoints
# -------------------------------------------------------------------------------------------
BASE_URL = 'https://bcsapi.xyz/api'

# user agent used in requests
# ---------------------------
USER_AGENT = 'rubyAPI1.0'

# main class
class Bestcaptchasolver
  def initialize(access_token)
    @_access_token = access_token
    @_affiliate_id = nil
    @_headers = {"User-Agent" => USER_AGENT}
  end

  # set affiliate id
  def set_affiliate_id(id)
    @_affiliate_id = id
  end

  # get accounts balance
  def account_balance
    url = '%s/user/balance?access_token=%s' % [BASE_URL, @_access_token]
    # make request
    response_text = JSON.parse(Net::HTTP.get URI(url))
    response_text['balance']
  end

  # submit b64 encoded image captcha
  def submit_captcha(d)
    url = '%s/captcha/image' % [BASE_URL]
    uri = URI.parse(url)
    d["access_token"] = @_access_token
    # check for affiliate ID
    if @_affiliate_id != nil
      d['affiliate_id'] = @_affiliate_id
    end
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri, @_headers)
    res = http.request(req, URI.encode_www_form(d))

    JSON.parse(res.body)['id']    # get response body
  end

  # submit recaptcha
  def submit_recaptcha(d)
    url = '%s/captcha/recaptcha' % [BASE_URL]
    uri = URI.parse(url)
    d["access_token"] = @_access_token
    # check for affiliate ID
    if @_affiliate_id != nil
      d['affiliate_id'] = @_affiliate_id
    end
    # check for proxy
    if d.key? 'proxy'
      d['proxy_type'] = 'HTTP'
    end

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri, @_headers)
    res = http.request(req, URI.encode_www_form(d))

    JSON.parse(res.body)['id']    # get response body
  end

  # retrieve captcha by ID
  def retrieve(id)
    url = '%s/captcha/%s?access_token=%s' % [BASE_URL, id, @_access_token]
    # make request
    response_text = JSON.parse(Net::HTTP.get URI(url))
    if response_text['status'] === 'pending'
      return nil
    end
    response_text
  end

  # set captcha bad using ID
  def set_captcha_bad (id)
    url = '%s/captcha/bad/%s' % [BASE_URL, id]
    uri = URI.parse(url)
    d = {}
    d["access_token"] = @_access_token
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri, @_headers)
    res = http.request(req, URI.encode_www_form(d))

    JSON.parse(res.body)['status'] # return body
  end
end

