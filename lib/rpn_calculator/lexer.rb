module RpnCalculator
  class OperandToken
    attr_accessor :value
    def initialize(value)
      self.value = value
    end

    def operator?
      false
    end

    def operand?
      true
    end
  end

  class OperatorToken
    attr_accessor :value
    def initialize(value)
      self.value = value
    end

    def operator?
      true
    end

    def operand?
      false
    end
  end

  class Lexer
    def parse(line)
      line.chomp.split.map do |token_string|
        case
        when token_string.match(/^-?[0-9]+$/)
          OperandToken.new token_string.to_i
        when token_string.match(/^\+$/)
          OperatorToken.new token_string.to_sym
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
