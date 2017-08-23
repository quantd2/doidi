ActionMailer::DeliveryJob.class_eval do
  rescue_from ActiveJob::DeserializationError do |exception|
    # Just skip this, we dont want to perform the job again
  end
end
