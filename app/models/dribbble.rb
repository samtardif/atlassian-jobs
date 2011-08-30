require 'rubygems'
require 'httparty'

class Dribbble
  include HTTParty
  base_uri 'http://api.dribbble.com'

  http_proxy 'web-cache.usyd.edu.au', 8080

  def self.get_stats(username)
    get('/players/' + username.to_s + '/shots')
  end
end
