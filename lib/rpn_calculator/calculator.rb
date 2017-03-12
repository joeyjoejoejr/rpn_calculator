module RpnCalculator
  class Calculator
    def initialize
      @operands = []
    end

    def run(tokens)
      tokens.map do |token|
        case
        when token.operand?
          operands << token.value
          token.value
        when token.operator?
          self.operands = operands.last(2)
          operands.reduce(token.value)
        end
      end.compact.last
    end

    private

    attr_accessor :operands
  end
end
