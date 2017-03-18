module RpnCalculator
  class Lexer
    class StringOperandToken
        attr_accessor :value
        def initialize(value)
          self.value = value
        end

        def execute(operands)
          operands.push(value)
          value
        end
    end
  end
end
