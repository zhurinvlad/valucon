class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def create
    @image = Image.create(image_params)
    redirect_to images_path
  end

  private

  def image_params
    params.permit(:image)
  end
end