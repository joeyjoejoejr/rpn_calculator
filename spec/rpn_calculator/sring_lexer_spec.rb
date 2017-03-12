require 'spec_helper'

module RpnCalculator
  RSpec.describe StringLexer do
    let(:lexer) { StringLexer.new }

    describe "#parse" do
      describe "parses string" do
        %w{hello a world}.each do |operand|
          it operand do
            parsed = lexer.parse operand

            expect(parsed.first.value).to eq operand
          end
        end
      end

      describe "parses operator" do
        %w{!concat}.each do |operator|
          it operator do
            parsed = lexer.parse operator

            expect(parsed.first).to be_a Lexer::StringOperatorToken
          end
        end
      end

      it "parses quit command" do
        lexer.parse '/q'

        expect(lexer).to be_quit
      end
    end
  end
end
