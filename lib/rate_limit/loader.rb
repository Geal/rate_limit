class RateLimit::Loader
  def initialize(cache)
    @cache = cache
  end

  def read(key)
    data = @cache.read(key)
    Marshal::load(data) unless data.nil?
  end

  def write(key, data)
    @cache.write(key, Marshal::dump(data))
  end

  def delete(key)
    @cache.delete(key)
  end
end
