class Image < ApplicationRecord
	dragonfly_accessor :image

	validates :image, presence: true
end
