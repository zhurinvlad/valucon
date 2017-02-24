require 'custom_error'
class RailsGem < ApplicationRecord
	RUBYGEMS_URL = 'https://rubygems.org'
	# TODO: Checks
	def check_version!(sha)
		begin
			raise CustomError::GemFileNotExist unless File.exists?(self.gem_copy)
			
			digest = Digest::SHA256.new
			file_sha = digest.file(self.gem_copy).hexdigest

			raise CustomError::BadVersionSHA unless file_sha == sha && sha == self.sha
		rescue
			# MY RECIPE(without update) Delete bad files, that next download actuality version
			File.delete(self.gem_copy) if File.exists?(self.gem_copy)
			self.destroy!
			DownloadVersion.perform_async(self.version, sha)
		end
	end

	private
	def self.check_all_versions
		# RailsGem.delete_all
	  	
		# Through the API given 293 versions, but on page https://rubygems.org/gems/rails/versions - 298
		uri = URI.parse("#{RUBYGEMS_URL}/api/v1/versions/rails.json")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		request = Net::HTTP::Get.new(uri.request_uri)
		request['Authorization'] = Rails.application.secrets.rubygems
		response = http.request(request)

		JSON.parse(response.body).each do |r|
			rails_gem = RailsGem.find_by(version: r['number'])
			if rails_gem
				CheckVersion.perform_async(rails_gem.id, r['sha'])
			else
				DownloadVersion.perform_async(r['number'], r['sha'])
			end
		end
	end

	def self.download(version, sha)
		path_file = "#{Dir.pwd}/valucon_downloads/rails-#{version}.gem"
		File.open(path_file, "wb") do |file|
		  file.write open("#{RUBYGEMS_URL}/gems/rails-#{version}.gem").read
		end
		RailsGem.create(version: version, gem_copy: path_file, sha: sha)
	end
end
