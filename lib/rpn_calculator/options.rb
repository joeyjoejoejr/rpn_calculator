module RpnCalculator
  class Options
    class ParseError < StandardError; end

    attr_accessor :io_streams, :parser, :logger

    def initialize(io_streams, logger)
      self.io_streams = io_streams
      self.logger = logger
      self.parser = OptionParser.new do |parser|
        parser.banner = "Usage: rpn_calculator [options] [file1] ... [filen]"

        parser.on "-h", "--help", "Prints help" do
          logger.message parser
        end
      end
    end

    def parse!
      $stdout = io_streams.output_stream
      $stderr = io_streams.output_stream
      parser.parse io_streams.argv
    rescue OptionParser::ParseError => error
      logger.error error, parser

      raise ParseError.new(error)
    ensure
      $stdout = STDOUT
      $stderr = STDERR
    end
  end
end
