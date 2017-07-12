module RollbarApi
  @@logger = Logger.new(STDOUT)
  def self.logger=(logger)
    @@logger = logger
  end

  def self.logger
    @@logger
  end
end
