require 'rubygems'
require 'httparty'

class Bitbucket
  include HTTParty
  base_uri 'https://api.bitbucket.org/1.0'

  def self.get_stats(username)
    get('/users/' + username.to_s)
  end
end
