require 'net/http'
namespace :versions_gems do
  desc "Query Rubygems API for all the versions of Rails gem"
  task :rails => :environment do
    path_downloads_folder = "#{Dir.pwd}/valucon_downloads"
    Dir.mkdir(path_downloads_folder) unless Dir.exists?(path_downloads_folder)
  	RailsGem.check_all_versions
  end
end