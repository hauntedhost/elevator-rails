class QueueController < ApplicationController
  def show
    id = params[:id]
    if id == "0"
        puts "QUEUE:"
        # p SuckerPunch::Queue[:test_queue].find(1)
        # p SuckerPunch::Queue[:test_queue]
    else
      # q = SuckerPunch::Queue.new(:test_queue)
      # q.async.perform(params[:id])
      # SuckerPunch::Queue[:test_queue].async.perform #(params[:id])
      SuckerPunch::Queue[:dispatch_queue].async.perform
    end
  end
end
