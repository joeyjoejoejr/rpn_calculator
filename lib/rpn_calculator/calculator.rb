module RpnCalculator
  class Calculator
    def initialize
      @operands = []
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
