class ReserveController < ApplicationController
  require 'net/http'
  require 'json'
  def index
  end
  def new     
    @orderbook = Net::HTTP.get(URI.parse("http://data.mtgox.com/api/1/BTCUSD/depth/fetch"))
    @orderbook_json = JSON.parse(@orderbook)
    if @orderbook_json["result"] == "success"
      @asks = JSON.parse(@orderbook)["return"]["asks"]
      @bids = JSON.parse(@orderbook)["return"]["bids"]#.reverse
    else
      raise "can not get data from url"
    end
    
    @amount = params[:amount]
    @commit = params[:commit]
    if @commit == "Sell"
      @index = 0
      size_of_bids = @bids.size
      @sell_amount_left = @amount.to_f
      @result = 0.0
      while (@sell_amount_left > 0 && @index < size_of_bids)
        if @sell_amount_left >= @bids[@index]["amount"]
          @sell_amount_left = @sell_amount_left - @bids[@index]["amount"]
          @index = @index +1
          @result = @result + (@bids[@index]["price"]*@bids[@index]["amount"])
        else
           @result = @result + (@bids[@index]["price"]*@sell_amount_left)
           @sell_amount_left = 0
        end
      end
      if @sell_amount_left == 0
        @result = @result + (@result * 0.01)
      else
        raise "amount is too large"
      end
    elsif @commit == "Buy"
      @index = 0
      size_of_asks = @asks.size
      @buy_amount_left = @amount.to_f
      @result = 0.0
      
      while (@buy_amount_left > 0 && @index < size_of_asks)
              if @buy_amount_left >= @asks[@index]["amount"]
                @buy_amount_left = @buy_amount_left.to_f - @asks[@index]["amount"].to_f
                @index = @index +1
                @result = @result + (@asks[@index]["price"].to_f*@asks[@index]["amount"].to_f)
              else
                 @result = @result + (@asks[@index]["price"].to_f*@buy_amount_left.to_f)
                 @buy_amount_left = 0
              end
      end
      
      if @buy_amount_left == 0
        @result = @result + (@result * 0.01)
      else
        raise "amount is too large"
      end
    else
      raise 'wrong option'
    end
    #add judgement
  end
end