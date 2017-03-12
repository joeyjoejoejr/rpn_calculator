module RpnCalculator
  PROMPT_MESSAGE = "rpn > "
  GOODBYE_MESSAGE = "Exiting interactive rpn..."
  ZERO_DIVISION_MESSAGE = "That's how you make black holes, be careful!"

  class Logger
    def initialize(io_streams)
      self.output_stream = io_streams.output_stream
      self.error_stream = io_streams.error_stream
      @tty = STDIN.isatty
    end

    def message(message)
      output_stream.puts message
    end

    def error(*message)
      error_stream.puts(*message)
    end

    def next_line
      output_stream.print PROMPT_MESSAGE if is_tty?
    end

    def goodbye
      output_stream.puts GOODBYE_MESSAGE if is_tty?
    end

    private

    attr_accessor :output_stream, :error_stream

    def is_tty?
      @tty
    end
  end
end
