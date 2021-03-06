require "pry"
require "spec_helper"
require "parser"

RSpec.describe Parser do
  let(:parser) { described_class.new(file_path) }
  let(:file_path) { "./spec/support/test.log" }

  describe ".call" do
    context "with given path" do
      it "returns Array" do
        expect(parser.call).to be_kind_of(Array)
      end

      it "returns Parser::LogData" do
        expect(parser.call).to include(a_kind_of(Parser::LogData))
      end
    end

    context "without path" do
      let(:file_path) { nil }

      it "raises an error" do
        expect { parser.call }.to raise_error(Parser::Error)
      end
    end
  end
end
