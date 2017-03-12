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
    end
  end
end
