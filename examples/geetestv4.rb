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
  d['domain'] = 'https://example.com'
  d['captchaid'] = '647f5ed2ed8acb4be36784e01556bb71'
  # d['affiliate_id'] = 'ID of affiliate'   # optional
  id = bcs.submit_geetest_v4 d

  puts "Waiting for geetestv4 to be solved ..."
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
    puts "[!] Error occured: #{details}"
  end
end

main
