require 'spec_helper'

module RpnCalculator
  RSpec.describe Calculator do
    let(:calculator) { Calculator.new }

    describe "#start" do
      it "adds negative numbers" do
        tokens = [
          OperandToken.new(-1),
          OperandToken.new(-1),
          OperatorToken.new(:+),
        ]

        result = calculator.run tokens

        expect(result).to eq -2
      end

      it "works with no numbers" do
        tokens = [
          OperatorToken.new(:+),
        ]

        result = calculator.run tokens

        expect(result).to be 0
      end

      it "only operates on the last two numbers" do
        tokens = (1..100).map { |val| OperandToken.new(val) }
        tokens << OperatorToken.new(:+)


        result = calculator.run tokens

        expect(result).to eq 199
      end

      it "saves the last result in the operands" do
        tokens = [
          OperandToken.new(1),
          OperandToken.new(1),
          OperatorToken.new(:+),
          OperandToken.new(1),
          OperatorToken.new(:+),
        ]

        result = calculator.run tokens

        expect(result).to eq 3
      end

      it "works with with floats" do
        tokens = [
          OperandToken.new(0.1),
          OperandToken.new(0.1),
          OperatorToken.new(:+),
        ]

        result = calculator.run tokens

        expect(result).to eq 0.2
      end

      it "subtracts" do
        tokens = [
          OperandToken.new(5),
          OperandToken.new(4),
          OperatorToken.new(:-),
        ]

        result = calculator.run tokens

        expect(result).to eq 1
      end

      it "multiplies" do
        tokens = [
          OperandToken.new(5),
          OperandToken.new(4),
          OperatorToken.new(:*),
        ]

        result = calculator.run tokens

        expect(result).to eq 20
      end

      it "devides" do
        tokens = [
          OperandToken.new(20),
          OperandToken.new(4),
          OperatorToken.new(:/),
        ]

        result = calculator.run tokens

        expect(result).to eq 5
      end

      it "handles divite by zero" do
        tokens = [
          OperandToken.new(1),
          OperandToken.new(0),
          OperatorToken.new(:/),
        ]

        expect { calculator.run tokens }.not_to raise_error
      end
    end
  end
end
