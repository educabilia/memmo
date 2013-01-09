class Memmo
  def self.enabled
    @enabled
  end

  def self.enabled=(value)
    @enabled = value
  end

  def initialize
    @mutex = Mutex.new
    @loaders = {}
    @cache = {}
  end

  def register(name, options = {}, &block)
    @mutex.synchronize do
      @loaders[name] = [options, block]
      refresh(name)
    end
  end

  def get(name)
    return refresh(name)[1] unless Memmo.enabled

    if !@cache.include?(name) || (@loaders[name][0][:ttl] && Time.now - @cache[name][0] > @loaders[name][0][:ttl])
      @mutex.synchronize do
        refresh(name)
      end
    end

    @cache[name][1]
  end

  def clear
    @cache.clear
  end

  def [](name)
    get(name)
  end

  self.enabled = true

protected

  def refresh(name)
    @cache[name] = [Time.now, @loaders[name][1].call]
  end
end
