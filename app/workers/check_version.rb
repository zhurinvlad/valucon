require 'digest'
class CheckVersion
  include Sidekiq::Worker
  sidekiq_options queue: 'rubygems', :retry => false
  def perform(id, sha)
  	rails_gem = RailsGem.find(id)
	  rails_gem.check_version!(sha)
  end
end