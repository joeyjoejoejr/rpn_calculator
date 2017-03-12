module RpnCalculator
  class InteractiveCalculator
    PROMPT_MESSAGE = "rpn > "
    GOODBYE_MESSAGE = "Exiting interactive rpn..."
    def self.start(input_stream = STDIN, output_stream = STDOUT)
      digits = []
      is_tty = input_stream.isatty
      output_stream.puts "I'm a tty? #{is_tty}"
      loop do
        done = false
        output_stream.print PROMPT_MESSAGE if is_tty
        input_stream.readline.chomp.split.each do |token|
          case
          when token.match(/^-?[0-9]+$/)
            output_stream.puts token if is_tty
            digits << token.to_i
            digits = digits.last(2)
          when token.match(/^\+$/)
            output_stream.puts digits.reduce(:+)
            digits = []
          when token.match(/^q$/i)
            output_stream.puts GOODBYE_MESSAGE if is_tty
            done = true
          end
        end

        done && break;
      end

    rescue Interrupt, EOFError
      output_stream.puts GOODBYE_MESSAGE if is_tty
    end
  end
end
