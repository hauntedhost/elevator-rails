class CabCallsController < ApplicationController
  before_filter :wake_dispatcher

  def new
    @call = CabCall.new
  end

  def create
    call = CabCall.new(params[:cab_call])
    if call.save
      render :json => call
    else
      render :json => call, :status => :unprocessable_entity
    end
  end

end
