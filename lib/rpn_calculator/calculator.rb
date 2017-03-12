module RpnCalculator
  class Calculator
    def initialize
      @operands = [0]
    end

    def run(tokens)
      tokens.map do |token|
        case
        when token.operand?
          operands << token.value

          token.value
        when token.operator?
          operands.last(2).reduce(token.value).tap do |operand|
            raise ZeroDivisionError unless operand.finite?
            operands << operand
            self.operands = operands.last(2)
          end
        end
      end.compact.last

    rescue
      ZERO_DIVISION_MESSAGE
    end

    private

    attr_accessor :operands
  end
end
