require 'net/http'
namespace :versions_gems do
  desc "Query Rubygems API for all the versions of Rails gem"
  task :rails => :environment do
  	RailsGem.check_all_versions
  end
end