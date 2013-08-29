class ReserveController < ApplicationController
  def index
  end
  def new
    @username = params[:username]
  end
  def save
    @user = User.new
    if !User.find_by_username(params[:username]) && !User.find_by_email(params[:email]) #not safe
     @user.username = params[:username]
     @user.email = params[:email]
     @user.save
     UserMailer.welcome_email(@user)
    else
      raise 'exists'
    end    
    #send email
  end
end
