require 'spec_helper'

module RpnCalculator
  RSpec.describe Options do
    describe "#parse" do
      let(:output_stream) { StringIO.new }
      let(:err_stream) { StringIO.new }
      let(:input_stream) { StringIO.new }
      let(:io_streams) do
        IOStreams.new(error_stream: err_stream,
                      output_stream: output_stream,
                      argf: input_stream)
      end

      it "calls the block given with the value" do
        io_streams.argv = %w{-t string}
        logger = double()
        results = ''

        options = Options.new(io_streams, logger) do |type|
          results = type
        end
        options.parse!
        expect(results).to be :string
      end
    end
  end
end
