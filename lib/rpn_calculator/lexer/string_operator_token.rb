module RpnCalculator
  class Lexer
    class StringOperatorToken
      attr_accessor :value
      def initialize(value)
        self.value = value
      end

      def execute(operands)
        operands.last(2).reduce(&method(value)).tap do |result|
          operands.push result
        end
      end

      def concat(acc, val)
        acc + val
      end
    end
  end
end
