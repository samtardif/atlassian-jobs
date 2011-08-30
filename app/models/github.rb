require 'rubygems'
require 'httparty'

class Github
  include HTTParty
  base_uri 'github.com/api/v2/json'

  # if ENV['HTTP_PROXY']
  #   uri = URI.parse(ENV['HTTP_PROXY'])
  http_proxy 'web-cache.usyd.edu.au', 8080
  # end

  def self.get_stats(username)
    get("/user/show/" + username.to_s)
  end
end
