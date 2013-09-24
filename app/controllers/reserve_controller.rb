class ReserveController < ApplicationController

  def index
  end
  
  def new
    @username = params[:username]
    #add judgement
  end
  
  def save
    @user = User.new
    @username_flag = false
    @email_flag = false
    
    @username_flag = User.find_by_username(params[:username])
    @email_flag = User.find_by_email(params[:email])
    if !@username_flag && !@email_flag
     @user.username = params[:username]
     @user.email = params[:email]
     if @user.save
       UserMailer.signup_confirmation(@user).deliver
     else
      #raise 'can not send email'
       logger.info("can not send email for #{@user.username}")
     end
    end
  end

end
