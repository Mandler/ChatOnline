class UserMailerPreview < ActionMailer::Preview
  def password_change
    Devise::Mailer.password_change(User.first, {})
  end
end
