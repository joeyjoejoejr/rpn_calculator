require "optparse"

module RpnCalculator
  class Cli

    attr_accessor :io_streams, :logger, :lexer, :calculator, :option_parser

    def initialize(io_streams: IOStreams.new, logger: Logger.new(io_streams))
      self.io_streams = io_streams
      self.logger = logger
      self.lexer = Lexer.new
      self.calculator = Calculator.new
      self.option_parser = Options.new(io_streams, logger)
    end

    def start
      option_parser.parse!

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
