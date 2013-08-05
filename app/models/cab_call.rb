# == Schema Information
#
# Table name: cab_calls
#
#  id              :integer          not null, primary key
#  requested_floor :integer          not null
#  direction       :string(255)      not null
#  cab_id          :integer
#  status          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class CabCall < ActiveRecord::Base
  attr_accessible :cab_id, :direction, :requested_floor, :status
  validates_inclusion_of :status, :in => ["pending", "complete"]
  before_create :set_status
  belongs_to :cab

  def self.unassigned
    CabCall.where(:cab_id => nil)
  end

  private
  def set_status
    self.status = "pending"
  end
end
