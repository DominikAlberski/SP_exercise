require "spec_helper"
require "parser"

RSpec.describe Parser do
  let(:service) { described_class.new(file_path) }
  let(:file_path) { "/spec/support/test.log" }


  describe ".call" do
    let(:result) do
      <<-TEXT
        /help_page/1 2 visits
        /contact 1 visit
        /home 1 visit
        /about/2 1 visit
      TEXT
    end
    it "outputs list of pages views asc"
      expect(service.call).to eq(result)
    end
  end
end
