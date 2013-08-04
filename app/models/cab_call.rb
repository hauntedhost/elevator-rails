# == Schema Information
#
# Table name: cab_calls
#
#  id         :integer          not null, primary key
#  from_floor :integer          not null
#  direction  :string(255)      not null
#  cab_id     :integer
#  status     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CabCall < ActiveRecord::Base
  attr_accessible :cab_id, :direction, :from_floor, :status
  scope :unassigned, where(:cab_id => nil) #.order("created_at DESC")
  scope :active, where(:status => "active").order("created_at DESC")
  before_save :set_status

  belongs_to :cab

  private
  def set_status
    self.status = "active"
  end
end
