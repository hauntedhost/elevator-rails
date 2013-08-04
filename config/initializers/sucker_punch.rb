SuckerPunch.config do
  # queue name: :test_queue, worker: TestWorker, workers: 10
  queue name: :dispatch_queue, worker: DispatchWorker, workers: 10
end
