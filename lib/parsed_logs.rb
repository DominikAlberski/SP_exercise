class ParsedLogs
  def self.call(*args)
    new(*args).call
  end

  def initialize(options, presenter, parser, data_processor)
    self.path = options.first
    self.parser = parser
    self.data_processor = data_processor
    self.presenter = presenter.new
  end

  def call
    display_result
  end

  private

  attr_accessor :path, :parser, :data_processor, :presenter

  def data
    @data ||= parser.call(path)
  end

  def processed_data
    @processed_data ||= data_processor.call(data)
  end

  def display_result
    format(
      <<~TEXT,
        %<most_views>s
        %<unique_visits>s
      TEXT
      most_views: presenter.most_visits_template(processed_data.sorted_most_views),
      unique_visits: presenter.uniq_views_template(processed_data.sorted_unique_views)
    )

  end
end
