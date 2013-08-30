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
     if @user.save
       UserMailer.signup_confirmation(@user).deliver
     else
      raise 'can not send email'
     end
    else
      raise 'exists'
    end
  end
end
