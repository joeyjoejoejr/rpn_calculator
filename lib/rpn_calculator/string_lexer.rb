module RpnCalculator
  class StringLexer
    def parse(line)
      line.chomp.split.map do |token_string|
        case
        when token_string.match(/^\w+$/)
          Lexer::StringOperandToken.new token_string
        when token_string.match(/!(concat|sentence|capitalize|reverse)/)
          Lexer::StringOperatorToken.new token_string[1..-1].to_sym
        when token_string.match(/^\/q$/i)
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
