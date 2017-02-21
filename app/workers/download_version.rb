require 'open-uri'
class DownloadVersion
  include Sidekiq::Worker
  sidekiq_options queue: 'rubygems'
  def perform(version, sha)
	RailsGem.download(version, sha)
  end
end