require 'spec_helper'

module RpnCalculator
  class Lexer
    RSpec.describe StringOperatorToken do
      describe "!concat" do
        it "concats operands" do
          token = StringOperatorToken.new(:concat)
          result = token.execute(["hello", "world"])

          expect(result).to eq "helloworld"
        end
      end

      describe "!sentence" do
        it "combines operands into a sentence" do
          token = StringOperatorToken.new(:sentence)
          result = token.execute(["hello", "world"])

          expect(result).to eq "hello world."
        end
      end

      describe "!capitalize" do
        it "capitalizes operand" do
          token = StringOperatorToken.new(:capitalize)
          result = token.execute(["hello"])

          expect(result).to eq "Hello"
        end
      end

      describe "!reverse" do
        it "reverses operand" do
          token = StringOperatorToken.new(:reverse)
          result = token.execute(["hello"])

          expect(result).to eq "olleh"
        end
      end
    end
  end
end
