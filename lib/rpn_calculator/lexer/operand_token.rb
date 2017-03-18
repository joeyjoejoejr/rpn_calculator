require 'bigdecimal'
require 'bigdecimal/util'

module RpnCalculator
  class Lexer
    class OperandToken
      attr_accessor :value
      def initialize(value)
        self.value = value.to_d
      end

      def execute(operands)
        operands.push(value)
        value.to_f
      end
    end
  end
end
