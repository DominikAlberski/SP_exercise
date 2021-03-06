require "spec_helper"
require "presenter"

RSpec.describe Presenter do
  let(:presenter) { described_class.new }
  let(:data) do
    {
      "path/1" => 2,
      "path/" => 1,
    }
  end

  describe '#most_visits_template' do
    let(:result) do
      <<~TEXT
        Addresses with most visits:
        path/1 2 visits
        path/ 1 visit
      TEXT
    end

    it "returns formatted data entries" do
      expect(presenter.most_visits_template(data)).to eq(result)
    end
  end

  describe '#uniq_views_template' do
    let(:result) do
      <<~TEXT
        Addresses with most unique views:
        path/1 2 unique views
        path/ 1 unique view
      TEXT
    end

    it "returns formatted data entries" do
      expect(presenter.uniq_views_template(data)).to eq(result)
    end
  end
end
