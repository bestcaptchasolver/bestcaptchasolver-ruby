#!/usr/bin/ruby
load "../lib/bestcaptchasolver.rb"

def test_api
  access_token = "YOUR_ACCESS_TOKEN"
  # for more details check https://bestcaptchasolver.com/captchabypass-api
  bcs = Bestcaptchasolver.new(access_token)

  # check account balance
  balance = bcs.account_balance          # get balance
  puts "Account balance: $#{balance}"   # print balance

  d = {}
  d['page_url'] = 'PAGE_URL_HERE'
  d['site_key'] = 'SITE_KEY_HERE'

  # other parameters
  # ----------------------------------------------------------------------
  # reCAPTCHA type(s) - optional, defaults to 1
  # ---------------------------------------------
  # 1 - v2
  # 2 - invisible
  # 3 - v3
  # 4 - enterprise v2
  # 5 - enterprise v3
  #
  # d['type'] = 1
  #
  # d['v3_min_score'] = 0.3          # min score to target when solving v3 - optional
  # d['v3_action'] = 'homepage'      # action to use when solving v3 - optional
  # d['data_s'] = 'recaptcha data-s parameter used in loading reCAPTCHA' # - optional
  # d['cookie_input'] = 'a=b;c=d'    # used in solving of reCAPTCHA - optional
  # d['proxy'] = '126.45.34.53:123'  # - HTTP proxy - optional
  # d['user_agent'] = 'Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0' # optional
  # d['affiliate_id'] = 'ID of affiliate'   # optional
  id = bcs.submit_recaptcha d

  puts "Waiting for recaptcha to be solved ..."
  gresponse = nil
  while gresponse == nil  # while it"s still in progress
    gresponse = bcs.retrieve id
    sleep 10    # sleep for 10 seconds
  end
  puts "Gresponse: %s" % [bcs.retrieve(id)['gresponse']]

  # proxy status
  # puts "Proxy status: %s" % [ita.retrieve(id)['proxy_status']]

  # set captcha bad
  # puts bcs.set_captcha_bad id
end

def main
  begin
    test_api
  rescue => details
    puts "[!] Error occured: #{details}"
  end
end

main
