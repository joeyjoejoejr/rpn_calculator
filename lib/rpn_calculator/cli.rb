require "optparse"
require 'rpn_calculator/interactive_calculator'

module RpnCalculator
  class Cli
    class ParseError < StandardError; end

    attr_accessor :argv, :output_stream, :error_stream, :options

    def initialize(argv = ARGV, output_stream = STDOUT, error_stream = STDERR)
      self.argv = argv
      self.output_stream = output_stream
      self.error_stream = error_stream
      self.options = {}
      self.option_parser = OptionParser.new do |parser|
        parser.banner = "Usage: #{File.basename(__FILE__)} [options]"
        parser.on("-i",
                  "--interactive",
                  TrueClass,
                  "Start and interactive REPL") do |i|
          options[:interactive] = i
        end

        parser.on "-h", "--help", "Prints help" do
          output_stream.puts parser
        end
      end
    end

    def start
      parse_options!

      #TODO Refactor this
      if options[:interactive]
        InteractiveCalculator.start
      end
    end

    private

    attr_accessor :option_parser

    def parse_options!
      $stdout = output_stream
      $stderr = error_stream
      option_parser.parse argv
    rescue OptionParser::ParseError => error
      error_stream.puts error, option_parser

      raise ParseError.new(error)
    ensure
      $stdout = STDOUT
      $stderr = STDERR
    end
  end
end
