require "spec_helper"
require "parsed_logs"
require "presenter"
require "parser"
require "data_processor"

RSpec.describe ParsedLogs do
  let(:options) { ["path/to/log_file"] }
  let(:presenter) { class_double(Presenter) }
  let(:parser) { class_double(Parser) }
  let(:data_processor) { class_double(DataProcessor) }

  let(:processor_instance) do
    instance_double(
      DataProcessor,
      sorted_most_views: :data,
      sorted_unique_views: :data
    )
  end

  let(:presenter_instance) do
    instance_double(
      Presenter,
      most_visits_template: "visit logs",
      uniq_views_template: "unique logs"
    )
  end

  let(:service) do
    described_class.new(options, presenter, parser, data_processor)
  end

  before do
    allow(presenter).to receive_messages(new: presenter_instance)
    allow(parser).to receive_messages(call: :data)
    allow(data_processor).to receive_messages(call: processor_instance)
  end

  describe '#call' do
    before do
      service.call
    end

    it "calls parser" do
      expect(parser).to have_received(:call).with("path/to/log_file")
    end

    it "process data" do
      expect(data_processor).to have_received(:call).with(:data)
    end

    it "presents data" do
      expect(presenter).to have_received(:new)
      expect(presenter_instance)
        .to have_received(:most_visits_template)
        .with(:data)
      expect(presenter_instance)
        .to have_received(:uniq_views_template)
        .with(:data)
    end

    it "returns formated string" do
      expect(service.call).to eq "visit logs\nunique logs\n"
    end
  end
end
