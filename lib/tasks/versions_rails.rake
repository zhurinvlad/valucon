require 'net/http'
namespace :versions_gems do
  desc "Query Rubygems API for all the versions of Rails gem"
  task :rails => :environment do
  	RailsGem.delete_all
  	
  	# curl -H "Authorization:#{Rails.application.secrets.rubygems}" https://rubygems.org/api/v1/rails.json
	
	uri = URI.parse("https://rubygems.org/api/v1/versions/rails.json")
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	request = Net::HTTP::Get.new(uri.request_uri)
	request['Authorization'] = Rails.application.secrets.rubygems
	response = http.request(request)
	rails_gems = JSON.parse(response.body).map do |r|
		{
			version: r['number'],
			sha: r['sha']
		}
	end
	CheckVersion.perform_async('5.0.1')
	ActiveRecord::Base.transaction do 
		RailsGem.create!(rails_gems)
	end
  end
end