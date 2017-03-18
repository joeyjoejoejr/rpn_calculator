require 'spec_helper'
require 'bigdecimal'

module RpnCalculator
  RSpec.describe Lexer do
    let(:lexer) { Lexer.new }

    describe "#parse" do
      describe "parses integers" do
        %w{1 -1 10000000}.each do |operand|
          it operand do
            parsed = lexer.parse operand

            expect(parsed.first.value).to eq operand.to_f
          end
        end
      end

      describe "parses floats" do
        %w{ 1.0 0.2 -1.1 11.3 1.000000001}.each do |operand|
          it operand do
            parsed = lexer.parse operand

            expect(parsed.first.value).to be_a BigDecimal
            expect(parsed.first.value).to eq operand.to_f
          end
        end
      end

      describe "parses operator" do
        %w{+ - * / ** %}.each do |operator|
          it operator do
            parsed = lexer.parse operator

            expect(parsed.first.value).to be operator.to_sym
          end
        end
      end

      it "parses quit command" do
        lexer.parse 'q'

        expect(lexer).to be_quit
      end
    end
  end
end
