class DispatchWorker
  include SuckerPunch::Worker

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      second = 0
      loop do
        second += 1
        puts "#{second}"

        assign_cabs
        advance_cabs

        # BREAK when:
        # 1. all cabs are idle
        # 2. no unassigned calls left
        break if Cab.joins(:calls).empty?

        sleep 1
      end
    end
  end

  private
  def assign_cabs
    unassigned_calls = CabCall.unassigned
    unassigned_calls.each do |call|
      requested_direction = call.direction
      requested_floor = call.requested_floor

      # 1. try to assign to an approaching cab
      near_approaching = Cab.near_approaching(requested_floor, requested_direction)
      unless near_approaching.empty?
        cab = near_approaching.first
        call.cab = cab
        call.save
        next
      end

      # 2. else try to assign to nearest idle cab
      near_idle = Cab.near_idle(requested_floor)
      unless near_idle.empty?
        cab = near_idle.first
        call.cab = cab
        # cab.current_direction = requested_direction
        # cab.reserved_direction = requested_direction
        # cab.save
      end

      # 3. else try to assign to nearest returning cab
      # <insert profitable code here>

      # 4. else skip cab assignment this round
      # call is in queue it will be assigned in good time
    end
  end

  def advance_cabs
    cabs = Cab.in_transit #.joins(:calls)
    puts "found #{cabs.size} cabs with calls"
    cabs.each do |cab|
      current_floor = cab.current_floor + (cab.current_direction / 4)
      cab.current_floor = current_floor
      cab.calls.where(requested_floor: 3).update_all(status: "complete")
      if cab.calls.empty?
        cab.status = "idle"
      end
      cab.save
    end
  end

end
