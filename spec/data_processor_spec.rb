require "spec_helper"
require "data_processor"

RSpec.describe DataProcessor do
  let(:service) { described_class.new(data) }
  let(:data_double_1) { double(path: "path/", net_address: "123.0.0.1") }
  let(:data_double_2) { double(path: "path/1", net_address: "123.0.0.2") }
  let(:data_double_3) { double(path: "path/1", net_address: "123.0.0.3") }
  let(:data) { [data_double_1, data_double_2, data_double_3] }

  describe '.call' do
    let(:service) { described_class }

    it "initialize class" do
      expect(service.call(:data)).to be_instance_of(described_class)
    end
  end

  describe '#sorted_most_views' do
    let(:result) do
      {
        "path/1" => 2,
        "path/" => 1,
      }
    end

    it "returns sorted most views data" do
      expect(service.sorted_most_views).to eq(result)
    end
  end

  describe '#sorted_unique_views' do
    let(:result) do
      {
        "path/1" => 2,
        "path/" => 1
      }
    end

    it "returns sorted unique data" do
      expect(service.sorted_unique_views).to eq(result)
    end
  end
end
