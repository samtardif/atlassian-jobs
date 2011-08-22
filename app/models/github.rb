require 'rubygems'
require 'httparty'

class Github
  include HTTParty
  base_uri 'github.com/api/v2/json'

  def self.get_stats(username)
    get("/user/show/" + username.to_s)
  end
end
