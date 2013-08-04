class TestWorker
  include SuckerPunch::Worker

  # @workers = []

  def perform(id)
    p "workers: #{workers}"
    p "busy size #{SuckerPunch::Queue[:test_queue].busy_size}"

    1.upto(60) do |second|
      puts "#{id}: #{second}"
      sleep 1
    end
  end
end
