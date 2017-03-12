module RpnCalculator
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
