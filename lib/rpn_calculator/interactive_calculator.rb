module RpnCalculator
  class InteractiveCalculator
    def self.start(input_stream = STDIN, output_stream = STDOUT)
      digits = []
      loop do
        done = false
        input_stream.gets.chomp.split.each do |token|
          case
          when token.match(/^-?[0-9]+$/)
            digits << token.to_i
          when token.match(/^\+$/)
            output_stream.puts digits.reduce(:+)
            digits = []
          when token.match(/^q$/i)
            output_stream.puts "Goodbye!"
            done = true
          end
        end

        done && break;
      end
    end
  end
end
