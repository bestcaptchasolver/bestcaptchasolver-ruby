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
    @_headers = {"User-Agent" => USER_AGENT}
  end

  # get accounts balance
  def account_balance
    url = '%s/user/balance?access_token=%s' % [BASE_URL, @_access_token]
    # make request
    r = JSON.parse(Net::HTTP.get URI(url))
    # check for error
    if r.key? 'error'
      raise(r['error'])
    end
    r['balance']
  end

  # submit b64 encoded image captcha
  def submit_captcha(d)
    url = '%s/captcha/image' % [BASE_URL]
    uri = URI.parse(url)
    d["access_token"] = @_access_token
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri, @_headers)
    res = http.request(req, URI.encode_www_form(d))

    r = JSON.parse(res.body)
    # check for error
    if r.key? 'error'
      raise(r['error'])
    end
    r['id']    # get ID
  end

  # submit recaptcha
  def submit_recaptcha(d)
    url = '%s/captcha/recaptcha' % [BASE_URL]
    uri = URI.parse(url)
    d["access_token"] = @_access_token
    # check for proxy
    if d.key? 'proxy'
      d['proxy_type'] = 'HTTP'
    end

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri, @_headers)
    res = http.request(req, URI.encode_www_form(d))

    r = JSON.parse(res.body)
    # check for error
    if r.key? 'error'
      raise(r['error'])
    end
    r['id']    # get ID
  end

  # submit geetest
  def submit_geetest(d)
    url = '%s/captcha/geetest' % [BASE_URL]
    uri = URI.parse(url)
    d["access_token"] = @_access_token

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri, @_headers)
    res = http.request(req, URI.encode_www_form(d))

    r = JSON.parse(res.body)
    # check for error
    if r.key? 'error'
      raise(r['error'])
    end
    r['id']    # get ID
  end

  # submit capy
  def submit_capy(d)
    url = '%s/captcha/capy' % [BASE_URL]
    uri = URI.parse(url)
    d["access_token"] = @_access_token

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri, @_headers)
    res = http.request(req, URI.encode_www_form(d))

    r = JSON.parse(res.body)
    # check for error
    if r.key? 'error'
      raise(r['error'])
    end
    r['id']    # get ID
  end

  # submit hcaptcha
  def submit_hcaptcha(d)
    url = '%s/captcha/hcaptcha' % [BASE_URL]
    uri = URI.parse(url)
    d["access_token"] = @_access_token

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri, @_headers)
    res = http.request(req, URI.encode_www_form(d))

    r = JSON.parse(res.body)
    # check for error
    if r.key? 'error'
      raise(r['error'])
    end
    r['id']    # get ID
  end

  # retrieve captcha by ID
  def retrieve(id)
    url = '%s/captcha/%s?access_token=%s' % [BASE_URL, id, @_access_token]
    # make request
    r = JSON.parse(Net::HTTP.get URI(url))
    # check for error
    if r.key? 'error'
      raise(r['error'])
    end
    if r['status'] === 'pending'
      return nil
    end
    r   # return response
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

    r = JSON.parse(res.body)
    # check for error
    if r.key? 'error'
      raise(r['error'])
    end
    r['status']   # return status
  end
end

