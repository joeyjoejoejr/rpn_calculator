module RpnCalculator
  class InteractiveCalculator
    PROMPT_MESSAGE = "rpn > "
    GOODBYE_MESSAGE = "Exiting interactive rpn..."
    def self.start(input_stream = STDIN, output_stream = STDOUT)
      digits = []
      loop do
        done = false
        input_stream.gets.chomp.split.each do |token|
        output_stream.print PROMPT_MESSAGE
          case
          when token.match(/^-?[0-9]+$/)
            output_stream.puts token
            digits = [digits[-1], token.to_i]
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
    end
  end
end
