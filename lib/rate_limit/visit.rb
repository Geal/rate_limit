class RateLimit::BlockedVisit
  attr_accessor :visits, :start_time
  def initialize(visits, date)
    @visits = visits
    @start_time = date
  end
end

class RateLimit::SlowedVisit
  attr_accessor :visits, :previous
  def initialize(visits = 0, previous)
    @visits = visits
    @previous = previous
  end
end
