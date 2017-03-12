module RpnCalculator
  class InteractiveCalculator
    PROMPT_MESSAGE = "rpn > "
    GOODBYE_MESSAGE = "Exiting interactive rpn..."
    def self.start(input_stream = STDIN, output_stream = STDOUT)
      digits = []
      loop do
        done = false
        output_stream.print PROMPT_MESSAGE
        input_stream.readline.chomp.split.each do |token|
          case
          when token.match(/^-?[0-9]+$/)
            output_stream.puts token
            digits << token.to_i
            digits = digits.last(2)
          when token.match(/^\+$/)
            output_stream.puts digits.reduce(:+)
            digits = []
          when token.match(/^q$/i)
            output_stream.puts GOODBYE_MESSAGE
            done = true
          end
        end

        done && break;
      end

    rescue Interrupt, EOFError
      output_stream.puts GOODBYE_MESSAGE
    end
  end
end
