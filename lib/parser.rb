require_relative "parser/error"

class Parser
  LogData = Struct.new(:path, :net_address)

  def self.call(...)
    new(...).call
  end

  def initialize(path)
    self.path = path
  end

  def call
    raise(Error, "path must be given") unless path

    data
  end

  private

  attr_accessor :path, :presenter, :data_processor

  def data
    @data ||= File
      .foreach(path, chomp: true)
      .map { |line| LogData.new(*(line.split)) }
  end
end
