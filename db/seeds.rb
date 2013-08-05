# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cab.create([
  { current_floor: 10.0, 
    status: "transit", 
    current_direction: -1, 
    reserved_direction: -1 },
  { current_floor: 10.0, 
    status: "idle", 
    current_direction: 0, 
    reserved_direction: 0 },
  { current_floor: 10.0, 
    status: "idle", 
    current_direction: 0, 
    reserved_direction: 0 },
])

CabCall.create([
  { requested_floor: 3, 
    direction: -1, 
    cab_id: 1,
    status: "pending"
  },
  { requested_floor: 5, 
    direction: 1, 
    status: "pending"
  },
  { requested_floor: 10, 
    direction: -1, 
    status: "pending"
  }
])
