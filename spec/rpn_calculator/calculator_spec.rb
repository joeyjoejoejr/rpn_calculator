require 'spec_helper'

module RpnCalculator
  RSpec.describe Calculator do
    let(:calculator) { Calculator.new }

    describe "#start" do
      it "adds negative numbers" do
        tokens = [
          Lexer::OperandToken.new(-1),
          Lexer::OperandToken.new(-1),
          Lexer::OperatorToken.new(:+),
        ]

        result = calculator.run tokens

        expect(result).to eq -2
      end

      it "works with no numbers" do
        tokens = [
          Lexer::OperatorToken.new(:+),
        ]

        result = calculator.run tokens

        expect(result).to be 0.0
      end

      it "only operates on the last two numbers" do
        tokens = (1..100).map { |val| Lexer::OperandToken.new(val) }
        tokens << Lexer::OperatorToken.new(:+)


        result = calculator.run tokens

        expect(result).to eq 199
      end

      it "pops the values from the stack" do
        tokens = [
          Lexer::OperandToken.new(5.0),
          Lexer::OperandToken.new(9.0),
          Lexer::OperandToken.new(1.0),
          Lexer::OperatorToken.new(:-),
          Lexer::DivisionOperatorToken.new(:/),
        ]

        result = calculator.run tokens

        expect(result).to eq 0.625
      end

      it "works with with floats" do
        tokens = [
          Lexer::OperandToken.new(0.1),
          Lexer::OperandToken.new(0.1),
          Lexer::OperatorToken.new(:+),
        ]

        result = calculator.run tokens

        expect(result).to eq 0.2
      end

      it "subtracts" do
        tokens = [
          Lexer::OperandToken.new(5),
          Lexer::OperandToken.new(4),
          Lexer::OperatorToken.new(:-),
        ]

        result = calculator.run tokens

        expect(result).to eq 1
      end

      it "multiplies" do
        tokens = [
          Lexer::OperandToken.new(5),
          Lexer::OperandToken.new(4),
          Lexer::OperatorToken.new(:*),
        ]

        result = calculator.run tokens

        expect(result).to eq 20
      end

      it "divides" do
        tokens = [
          Lexer::OperandToken.new(20.0),
          Lexer::OperandToken.new(4.0),
          Lexer::DivisionOperatorToken.new(:/),
        ]

        result = calculator.run tokens

        expect(result).to eq 5
      end

      it "handles divite by zero" do
        tokens = [
          Lexer::OperandToken.new(1),
          Lexer::OperandToken.new(0),
          Lexer::DivisionOperatorToken.new(:/),
        ]

        expect { calculator.run tokens }.not_to raise_error
      end
    end
  end
end
