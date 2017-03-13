module RpnCalculator
  class Lexer
    class DivisionOperatorToken
      attr_accessor :value
      def initialize(value)
        self.value = value
      end

      def execute(operands)
        operands.pop(2).reduce(value).tap do |result|
          raise ZeroDivisionError unless result.finite?
          operands.push(result).compact!
        end

      rescue ZeroDivisionError
        ZERO_DIVISION_MESSAGE
      end
    end
  end
end
