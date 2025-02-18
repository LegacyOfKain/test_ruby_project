# frozen_string_literal: true
require 'http'
require 'openssl'
require 'oj'

puts 'Hello world!'

response = HTTP.get("https://jsonplaceholder.typicode.com/comments?postId=1",
                    ssl_context: OpenSSL::SSL::SSLContext.new.tap { |ctx| ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE })
puts response.status
str_body = response.body.to_s
json_body = Oj.load(str_body)
puts json_body.first['body']
puts json_body.first['email']

puts
puts 'JSON parsing...'
h = { 'one' => 1, 'array' => [ true, false ] }
json = Oj.dump(h)
h2 = Oj.load(json)
puts "Same? #{h == h2}"
