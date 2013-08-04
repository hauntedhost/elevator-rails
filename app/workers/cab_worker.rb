class CabWorker
  include SuckerPunch::Worker

  def perform(id)
    1.upto(60) do |second|
      puts "#{id}: #{second}"
      sleep 1
    end
  end
end
