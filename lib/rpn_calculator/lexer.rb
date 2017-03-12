module RpnCalculator
  class OperandToken
    attr_accessor :value
    def initialize(value)
      self.value = value
    end

    def execute(operands)
      operands.push(value)
    end
  end

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

  class Lexer
    def parse(line)
      line.chomp.split.map do |token_string|
        case
        when token_string.match(/^-?[0-9]\.?[0-9]*+$/)
          OperandToken.new token_string.to_f
        when token_string.match(/^([\+\*-]|\*\*)?$/)
          OperatorToken.new token_string.to_sym
        when token_string.match(/^[\/%]$/)
          DivisionOperatorToken.new token_string.to_sym
        when token_string.match(/^q$/i)
          @quit = true
          nil
        end
      end.compact
    end

    def quit?
      quit
    end

    private
    attr_accessor :quit
  end
end
