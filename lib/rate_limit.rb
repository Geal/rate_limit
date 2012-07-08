require "rate_limit/version"
require "rate_limit/loader"
require "rate_limit/visit"

module RateLimit
  def self.limitByIp(request, requests_per_seconds = 1, cache = Rails.cache)
    loader = Loader.new cache

    timestamp = Time.new.to_time.to_i
    key = request.remote_ip+request.fullpath
    puts key
    counter = loader.read key
    if counter.nil?
      loader.write key, Visit.new(1, timestamp)
      true
    else
      counter.visits += 1
      time = timestamp - counter.start_time
      loader.write key, counter
      requests_per_seconds > counter.visits.to_f/time.to_f
    end
  end

end
