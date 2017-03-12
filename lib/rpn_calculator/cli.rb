require "optparse"

module RpnCalculator
  class Cli
    class ParseError < StandardError; end

    attr_accessor :io_streams, :logger, :lexer, :calculator

    def initialize(io_streams: IOStreams.new,
                   logger: Logger.new(io_streams),
                   lexer: Lexer.new,
                   calculator: Calculator.new)
      self.io_streams = io_streams
      self.logger = logger
      self.lexer = lexer
      self.calculator = calculator

      self.option_parser = OptionParser.new do |parser|
        parser.banner = "Usage: #{File.basename(__FILE__)} [options]"

        parser.on "-h", "--help", "Prints help" do
          logger.message parser
        end
      end
    end

    def start
      parse_options!

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

    private

    attr_accessor :option_parser

    def parse_options!
      $stdout = io_streams.output_stream
      $stderr = io_streams.output_stream
      option_parser.parse io_streams.argv
    rescue OptionParser::ParseError => error
      logger.error error, option_parser

      raise ParseError.new(error)
    ensure
      $stdout = STDOUT
      $stderr = STDERR
    end
  end
end
