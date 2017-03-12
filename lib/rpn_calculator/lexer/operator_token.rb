module RpnCalculator
  class Lexer
    class OperatorToken
      attr_accessor :value
      def initialize(value)
        self.value = value
      end

      def execute(operands)
        operands.last(2).reduce(value).tap do |result|
          operands.push result
        end
      end
    end
  end
end
