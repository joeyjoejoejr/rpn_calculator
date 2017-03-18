module RpnCalculator
  class Lexer
    class OperatorToken
      attr_accessor :value
      def initialize(value)
        self.value = value
      end

      def execute(operands)
        operands.pop(2).reduce(value).tap do |result|
          operands.push(result).compact!
        end.to_f
      end
    end
  end
end
