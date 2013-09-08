class ReserveController < ApplicationController
  def index
  end
  def new
    @amount = params[:amount]
    @price = 100
    @commit = params[:commit]
    #add judgement
  end
end