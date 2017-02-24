class Image < ApplicationRecord
	dragonfly_accessor :image

	validates :image, presence: true
	validates_property :format, of: :image, in: [:jpeg, :jpg, :png, :bmp], case_sensitive: false,
										 message: "should be either .jpeg, .jpg, .png, .bmp", if: :image_changed?
end
