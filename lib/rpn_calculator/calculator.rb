module RpnCalculator
  class Calculator
    def initialize
      @operands = [0]
    end

    def run(tokens)
      tokens.map do |token|
        token.execute(@operands)
      end.compact.last
    end

    private

    attr_accessor :operands
  end
end
