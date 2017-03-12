module RpnCalculator
  class Lexer
    class StringOperatorToken
      attr_accessor :value
      def initialize(value)
        self.value = value
      end

      def execute(operands)
        public_send value, operands if operands.any?
      end

      def concat(operands)
        operands.last(2).reduce(:+).tap do |result|
          operands.push(result).compact!
        end
      end

      def sentence(operands)
        "#{operands.last(2).join ' '}.".tap do |result|
          operands.clear.push(result).compact!
        end
      end

      def capitalize(operands)
        operands.last.capitalize.tap do |result|
          operands.push(result).compact!
        end
      end

      def reverse(operands)
        operands.last.reverse.tap do |result|
          operands.push(result).compact!
        end
      end
    end
  end
end
