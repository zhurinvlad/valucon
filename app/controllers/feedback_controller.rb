class FeedbackController < ApplicationController
  def create
    FeedbackMailer.feedback(params[:email], params[:msg]).deliver if params[:email].present? && params[:msg].present?
  end
end