require "optparse"

module RpnCalculator
  class Cli
    attr_accessor :io_streams, :logger, :lexer, :calculator, :options

    def initialize(io_streams: IOStreams.new, logger: Logger.new(io_streams))
      self.io_streams = io_streams
      self.logger = logger
      self.lexer = Lexer.new
      self.calculator = Calculator.new
      self.options = Options.new(io_streams, logger) do |type|
        self.lexer = StringLexer.new if type == :string
      end
      options.parse!
    end

    def start
      return if options.is_help?
      start_input
    end

    private

    def start_input
      logger.next_line

      io_streams.argf.each_line do |line|
        logger.message calculator.run lexer.parse line
        lexer.quit? && break
        logger.next_line
      end

    rescue Interrupt, EOFError
    ensure
      logger.goodbye
    end
  end
end
