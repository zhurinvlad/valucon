ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "gmail.com",
    :user_name            => "afisazdorova",
    :password             => "1q2w3e4r5t0",
    :authentication       => "plain",
    :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "http://af.dev2.poloniumarts.com/"