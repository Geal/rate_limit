require "rate_limit/version"
require "rate_limit/loader"
require "rate_limit/visit"

module RateLimit
  def self.limitByIp(request, requests_per_seconds = 1, cache = Rails.cache)
    key = request.remote_ip+request.fullpath
    blockByKey(key, requests_per_seconds, cache)
  end

  def self.blockByKey(key, requests_per_seconds = 1, cache = Rails.cache)
    loader = Loader.new cache

    key = key+"b"
    timestamp = Time.new.to_time.to_i
    counter = loader.read key
    if counter.nil?
      loader.write key, BlockedVisit.new(1, timestamp)
      true
    else
      counter.visits += 1
      time = timestamp - counter.start_time
      loader.write key, counter
      requests_per_seconds > counter.visits.to_f/time.to_f
    end
  end

  def self.slowByKey(key, requests_per_seconds = 0.5, factor = 1, cache = Rails.cache)
    loader = Loader.new cache

    key = key+"s"
    timestamp = Time.new.to_time.to_i
    counter = loader.read key
    if counter.nil?
      loader.write key, SlowedVisit.new(1, timestamp)
      true
    else
      time = timestamp - counter.previous
      counter.previous = timestamp
      wait_time = requests_per_seconds*factor*counter.visits
      if wait_time < time
        loader.write key, counter
        true
      else
        counter.visits += 1
        loader.write key, counter
        false
      end
    end
  end
end
