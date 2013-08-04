# == Schema Information
#
# Table name: cabs
#
#  id            :integer          not null, primary key
#  current_floor :integer          not null
#  direction     :string(255)
#  status        :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# status: [idle, transit]
class Cab < ActiveRecord::Base
  attr_accessible :current_floor, :direction, :status
  # scope :in_transit, :where(:status => "transit")
  has_many :calls, :class_name => "CabCall"

  def self.in_transit
    Cab.where(:status => "transit")
  end

  # cabs nearest floor_n and/or traveling toward floor_n
  def self.nearest(floor_num, direction)
    operator = (direction == "up") ? "<" : ">"
    cabs = Cab.where(:direction => [direction, "none"]).
               where("current_floor #{operator} #{floor_num}")
    cabs.sort do |a, b|
      (a.current_floor - floor_num).abs <=> (b.current_floor - floor_num).abs
    end
  end

  # def self.by_proximity(floor_num)
  #   Cab.all.sort do |a, b|
  #     (a.current_floor - floor_num).abs <=> (b.current_floor - floor_num).abs
  #   end
  # end

end
