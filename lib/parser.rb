#!/usr/bin/env ruby
require 'pry'

class Parser
  LogData = Struct.new(:path, :net_address)

  def self.call(...)
    new(...).call
  end

  def initialize(options)
    self.path = options.first
  end

  def call
    return "no path to log given" unless path

    present_datas
  end

  private

  attr_accessor :path

  def present_datas
    datas.map do |path, data|
      number = data.values.sum
      format(
        "%<path>s %<number>s %<foo>s",
        path: path,
        number: number,
        foo: number > 1 ? "visits" : "visit"
      )
    end.join("\n")
  end

  def parsed_log
    data
  end

  def datas
    @datas ||= File
      .foreach(path, chomp: true)
      .map { |line| LogData.new(*(line.split)) }
      .inject(data_schema) do |memo, data|
        memo[data.path][data.net_address] += 1
        memo
      end
  end

  def data_schema
    Hash.new do |hash, key|
      hash[key] = Hash.new { |hash, key| hash[key] = 0 }
    end
  end
end

# {
#   path: {
#     uri: number
#   }
# }

# puts Parser.call(ARGV)
