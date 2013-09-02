class ReserveController < ApplicationController
  def index
  end
  def new
    @username = params[:username]
    #add judgement
  end
  def save
    @user = User.new
    if !User.find_by_username(params[:username]) && !User.find_by_email(params[:email]) #not safe
     @user.username = params[:username]
     @user.email = params[:email]
     if @user.save
       UserMailer.signup_confirmation(@user).deliver
     else
      #raise 'can not send email'
       logger.info("can not send email for #{@user.username}")
     end
    else
      logger.info("username: #{@user.username} or email exists")
      #raise 'username or email exists'
    end
  end
end
