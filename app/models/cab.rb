# == Schema Information
#
# Table name: cabs
#
#  id                 :integer          not null, primary key
#  current_floor      :float            not null
#  current_direction  :float(255)
#  status             :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  reserved_direction :float(255)
#

class Cab < ActiveRecord::Base
  attr_accessible :current_floor, :status, :current_direction, :reserved_direction
  validates_inclusion_of :status, :in => ["idle", "transit"]
  validates_inclusion_of :current_direction, :in => [-1, 0, 1]
  validates_inclusion_of :reserved_direction, :in => [-1, 0, 1]
  before_create :set_status
  has_many :calls, :class_name => "CabCall"
 
  def self.in_transit
    Cab.where(:status => "transit")
  end

  # cabs nearest floor_n and/or traveling toward floor_n
  def self.near_approaching(floor_num, requested_direction)
    # 1. elevator is moving in direction it's reserved to move
    # 2. elevator is moving in same direction as request
    # 3. elevator is properly above or below floor of request
    operator = (requested_direction == 1) ? "<" : ">"
    cabs = Cab.where(:current_direction => :reserved_direction).
               where(:current_direction => requested_direction).
               where("current_floor #{operator} #{floor_num}")

    # sort by proximity
    cabs.sort do |a, b|
      (a.current_floor - floor_num).abs <=> (b.current_floor - floor_num).abs
    end
  end

  # cabs nearest floor_n and idle
  def self.near_idle(floor_num)
    cabs = Cab.where(:status => "idle")

    # sort by proximity
    cabs.sort do |a, b|
      (a.current_floor - floor_num).abs <=> (b.current_floor - floor_num).abs
    end  
  end

  def self.near_returning(floor_num, requested_direction)
    # 1. elevator is NOT moving in same direction it's reserved to move
    # 2. but elevator IS reserved to ultimately move in same direction as request
    # 3. if elevator's current_direction == down
    #     turnaround_floor = LOWEST assigned cab_call floor
    #     requested_floor should be >= to turnaround_floor
    #   else
    #     turnaround_floor = HIGHEST assigned cab_call floor
    #     requested_floor should be <= to turnaround_floor

    # RAILS
    # operator = (direction == 1) ? "MAX" : "MIN"
    # cabs = Cab.select("*, #{operator}(requested_floor)").
    #            where(:reserved_direction => requested_direction).
    #            joins(:calls)

    # SQL
    # operator = (direction == 1) ? "MAX" : "MIN"
    # SELECT *, #{operator}(requested_floor)
    # FROM cabs
    # JOIN cab_calls ON cabs.id = cab_calls.cab_id 
    # WHERE cabs.current_direction != cabs.reserved_direction;

    # sqlite> select *, min(requested_floor) from cabs JOIN cab_calls on cabs.id = cab_calls.cab_id;
    # 1|10|down|idle|2013-08-04 07:02:23.378131|2013-08-05 04:05:16.905689|down|3|7|down|1|active|2013-08-04 07
  end

  private
  def set_status
    # self.status = "idle"
  end

end
