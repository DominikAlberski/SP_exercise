class DataProcessor
  def self.call(...)
     new(...)
  end

  def initialize(data)
    self.data = data
  end

  def sorted_most_views
    @sorted_most_views ||= sorted_hash(most_visits)
  end

  def sorted_unique_views
    @sorted_unique_views ||= sorted_hash(unique_views)
  end

  private

  attr_accessor :data

  def data_schema
    Hash.new do |hash, key|
      hash[key] = Hash.new { |hash, key| hash[key] = 0 }
    end
  end

  def formated_data
    @formated_data ||=
      data.inject(data_schema) do |memo, data|
        memo[data.path][data.net_address] += 1
        memo
      end
  end

  def most_visits
    @most_visits ||= formated_data
      .map { |path, data| [path, data.values.sum] }
  end

  def unique_views
    @unique_views ||= formated_data
      .map { |path, values| [path, values.keys.size] }
  end

  def sorted_hash(data)
    data
      .sort { |a, b| b[-1] <=> a[-1] }
      .to_h
  end
end
