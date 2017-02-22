class FeedbackMailer < ApplicationMailer
  def feedback(email,msg)
    @email = email
    @msg = msg
    mail(to: 'vz@poloniumarts.com', subject: "Feedback")
  end
end
