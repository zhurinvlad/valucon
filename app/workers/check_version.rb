class CheckVersion
  include Sidekiq::Worker
  def perform(version)
    puts RailsGem.find_by(version: version).sha
  end
end