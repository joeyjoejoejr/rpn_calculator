require 'spec_helper'

module RpnCalculator
  RSpec.describe Cli do
    describe "#start" do
      let(:input_stream) { StringIO.new }
      let(:output_stream) { StringIO.new }
      let(:err_stream) { StringIO.new }

      it "prints the help output" do
        argv = %w{-h}

        Cli.new(argv, output_stream).start

        expect(output_stream.string).to match /help/
      end

      it "handles malformed input" do
       argv = %w{--notanoption}

       expect {
         Cli.new(argv, output_stream, err_stream).start
       }.to raise_error(Cli::ParseError)

       expect(err_stream.string).to match /invalid option/
      end

      it "starts the interractive REPL if -i" do
        argv = %{-i}

        expect(InteractiveCalculator).to receive(:start)

        Cli.new(argv, output_stream).start
      end
    end
  end
end
