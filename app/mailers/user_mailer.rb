class UserMailer < ActionMailer::Base
  default from: "youhou.co@example.com"

  def signup_confirmation(user)
    @user = user
    @greeting = "Hi"

    mail to: @user.email,subject: "Sign Up Confirmation"
  end
end
