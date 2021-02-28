require 'pry'
require 'spec_helper'
require 'parser'

RSpec.describe Parser do
  let(:service) { described_class.new(file_path) }
  let(:file_path) { ["./spec/support/test.log"] }

  describe '.call' do
    let(:result) do
      <<-TEXT
        /help_page/1 2 visits
        /contact 1 visit
        /home 1 visit
        /about/2 1 visit
      TEXT
    end

    it 'outputs list of pages views' do
      expect(service.call.gsub(/\s/, "")).to include(result.gsub(/\s/, ""))
    end
  end
end
# /help_page/1 2 unique views
# /contact 1 unique view
# /home 1 unique view
# /about/2 1 unique view
