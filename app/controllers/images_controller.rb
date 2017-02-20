class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      flash[:success] = "Image saved!"
	else
      flash[:error] = "Image not saved!"
    end
    redirect_to images_path
  end

  private

  def image_params
    params.require(:image).permit(:image)
  end
end