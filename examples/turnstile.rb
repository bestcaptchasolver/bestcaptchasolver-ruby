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
  # d['action'] = 'taken from page source, optional'
  # d['cdata'] = 'taken from page source, optional'
  # d['domain'] = 'challenges.cloudflare.com'    # domain used in loading hcaptcha interface, default: challenges.cloudflare.com - optional
  # d['user_agent'] = 'your user agent'         # optional
  # d['proxy'] = 'user:pass@123.45.67.89:3031'  # optional
  # d['affiliate_id'] = 'ID of affiliate'       # optional
  id = bcs.submit_turnstile d

  puts "Waiting for turnstile to be solved ..."
  gresponse = nil
  while gresponse == nil  # while it"s still in progress
    gresponse = bcs.retrieve id
    sleep 10    # sleep for 10 seconds
  end
  puts "Solution: %s" % [bcs.retrieve(id)['solution']]

  # set captcha bad
  # puts bcs.set_captcha_bad id
end

def main
  begin
    test_api
  rescue => details
    puts "[!] Error occurred: #{details}"
  end
end

main
