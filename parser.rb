#!/usr/bin/env ruby
require 'optparse'

Options = Struct.new(:name)

OptionParser.new do |option|
  option.on("-p", "--path PATH",
            "path to file is required!") do |path|
    Parser.call(path)
  end
end.parse!


class Parser
  def self.call(...)
    new(...).call
  end

  def initialize(path)
    self.path = path
  end

  def call
    puts "most_pages_views"
  end

  private

  attr_accessor :path
end
