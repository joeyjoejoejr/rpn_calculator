module RpnCalculator
  class Lexer
    class DivisionOperatorToken
      attr_accessor :value
      def initialize(value)
        self.value = value
      end

      def execute(operands)
        operands.last(2).reduce(value).tap do |result|
          raise ZeroDivisionError unless result.finite?
          operands.push result
        end

      rescue ZeroDivisionError
        ZERO_DIVISION_MESSAGE
      end
    end
  end
end
