class ApplicationController < ActionController::Base
  protect_from_forgery

  def wake_dispatcher
    if SuckerPunch::Queue[:dispatch_queue].busy_size.zero?
      SuckerPunch::Queue[:dispatch_queue].async.perform
    end
  end

end
