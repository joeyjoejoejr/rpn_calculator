module RpnCalculator
  IOStreams = Struct.new :argv, :argf, :output_stream, :error_stream do
    def initialize(argv: ARGV,
                   argf: ARGF,
                   output_stream: STDOUT,
                   error_stream: STDERR)
      super argv, argf, output_stream, error_stream
    end
  end
end
