class RateLimit::Visit
  attr_accessor :visits, :start_time
  def initialize(visits, date)
    @visits = visits
    @start_time = date
  end
end
