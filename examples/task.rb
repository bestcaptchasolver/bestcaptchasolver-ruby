#!/usr/bin/ruby
load "../lib/bestcaptchasolver.rb"

def test_api
  access_token = "YOUR_ACCESS_TOKEN"
  # for more details check https://bestcaptchasolver.com/captchabypass-api
  bcs = Bestcaptchasolver.new(access_token)

  # check account balance
  balance = bcs.account_balance          # get balance
  puts "Account balance: $#{balance}"   # print balance

  d = {
    'template_name': 'Login test page',
    'page_url': 'https://bestcaptchasolver.com/automation/login',
    'variables': {"username": "xyz", "password": "0000"},
    # 'proxy': '126.45.34.53:345',   # or 126.45.34.53:123:joe:password
    # 'user_agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0',    # optional
  }
  id = bcs.submit_task d

  # submit pushVariables while task is being solved by the worker
  # very helpful, for e.g. in cases of 2FA authentication
  # bcs.task_push_variables(id, {"tfa_code": "1532"})

  puts "Waiting for task to be solved ..."
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
