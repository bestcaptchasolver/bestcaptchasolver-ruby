#!/usr/bin/ruby
load "../lib/bestcaptchasolver.rb"

def test_api
  access_token = "YOUR_ACCESS_TOKEN"
  # for more details check https://bestcaptchasolver.com/captchabypass-api
  bcs = Bestcaptchasolver.new(access_token)

  # check account balance
  balance = bcs.account_balance          # get balance
  puts "Account balance: $#{balance}"   # print balance

  puts "Solving image captcha ... "
  d = {
      'b64image': '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',
      # 'is_case': true,              # is case sensitive, defaults: false, optional
      # 'is_phrase': true,            # has at least one space, defaults: false, optional
      # 'is_math': true,              # math captcha calculation, defaults: false, optional
      # 'alphanumeric': 1,            # 1 - digits only, 2 - letters only, optional
      # 'minlength': 2,               # minimum text length, optional
      # 'maxlength': 5,               # maximum text length, optional
      # 'affiliate_id': 'ID of affiliate'   # optional
  }
  id = bcs.submit_captcha d
  puts "Waiting for captcha to be solved ..."
  image_text = nil
  while image_text == nil  # while it"s still in progress
    image_text = bcs.retrieve(id)
    sleep 5    # sleep for 10 seconds
  end
  puts "Captcha text: %s" % [bcs.retrieve(id)['text']]

  # set captcha bad
  #puts bcs.set_captcha_bad id
end

def main
  begin
    test_api
  rescue => details
    puts "[!] Error occurred: #{details}"
  end
end

main
