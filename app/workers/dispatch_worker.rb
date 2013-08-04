class DispatchWorker
  include SuckerPunch::Worker

  def assign_cabs
    unassigned_calls = CabCall.unassigned
    unassigned_calls.each do |call|
      direction = call.direction
      from_floor = call.from_floor

      # assign to first approaching cab
      close_cabs = Cab.nearest(from_floor, direction)
      unless close_cabs.empty?
        call.cab = close_cabs.first
        next
      end

      # otherwise assign to cab:
      # 1. with least amount of floors left to travel
      # 2. with closest final destination
      # calculation needs to include queued calls after elevator turns around

      cabs = Cab.by_proximity(from_floor)
      cabs.each do |cab|
        # if cab.
      end
    end
  end

  def advance_cabs
    cabs = Cab.in_transit
    cabs.each do |cab|
      # current_floor = cab.current_floor - .25
      # match = cab.calls.where(from_floor: current_floor)
      # if match

      # if 

      # if current_floor == cab.calls.last
    end
  end

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      second = 0
      loop do
        second += 1
        puts "#{second}"

        assign_cabs

        # TODO: break should happen when:
        # 1. all cabs are idle
        # 2. no unassigned calls
        break if CabCall.unassigned.empty?

        sleep 1
      end
    end
  end
end
