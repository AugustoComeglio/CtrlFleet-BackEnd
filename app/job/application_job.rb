# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  queue_as :default
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError

  # sidekiq_options queue: :default, retry: 5, expires_in: 1.hour
end
