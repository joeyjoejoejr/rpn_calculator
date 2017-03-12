require 'spec_helper'

module RpnCalculator
  RSpec.describe Cli do
    let(:output_stream) { StringIO.new }
    let(:err_stream) { StringIO.new }
    let(:input_stream) { StringIO.new }
    let(:io_streams) do
      IOStreams.new(error_stream: err_stream,
                    output_stream: output_stream,
                    argf: input_stream)
    end

    describe "#start" do
      it "prints the help output" do
        io_streams.argv = %w{-h}

        Cli.new(io_streams: io_streams).start

        expect(output_stream.string).to match /help/
      end

      it "handles malformed input" do
       io_streams.argv = %w{--notanoption}

       expect {
         Cli.new(io_streams: io_streams).start
       }.to raise_error(Cli::ParseError)

       expect(err_stream.string).to match /invalid option/
      end
    end

    describe "formatting" do
      before(:each) { allow(input_stream).to receive(:isatty).and_return true }
      it "shows a prompt on each line" do
        Cli.new(io_streams: io_streams).start

        expect(output_stream.string).to match /#{PROMPT_MESSAGE}/
      end

      it "echoes the input" do
        input_stream.puts "10 q"
        input_stream.rewind

        Cli.new(io_streams: io_streams).start

        expect(output_stream.string).to match /10/
      end

      it "shows the quitting message" do
        input_stream.puts "q"
        input_stream.rewind

        Cli.new(io_streams: io_streams).start

        expect(output_stream.string).to match /#{GOODBYE_MESSAGE}/i
      end

      it "doesn't show interactive output if it's not tty" do
        allow(STDIN).to receive(:isatty).and_return false
        input_stream.puts "q"
        input_stream.rewind

        Cli.new(io_streams: io_streams).start

        expect(output_stream.string).not_to match /#{GOODBYE_MESSAGE}/i
      end
    end

    describe "commands" do
      describe "+ command" do
        it "adds queued numbers" do
          input_stream.puts "1 1 + q"
          input_stream.rewind

          Cli.new(io_streams: io_streams).start

          expect(output_stream.string).to match /2/
        end

        it "adds queued negative numbers" do
          input_stream.puts "-1 -1 + q"
          input_stream.rewind

          Cli.new(io_streams: io_streams).start

          expect(output_stream.string).to match /-2/
        end

        it "works with no numbers" do
          input_stream.puts "+ q"
          input_stream.rewind

          Cli.new(io_streams: io_streams).start

          expect { output_stream.string }.not_to raise_error
        end

        it "only operates on the last two numbers" do
          input_stream.print (1..100).reduce('') { |acc, val| "#{acc} #{val}" }
          input_stream.puts " + q"
          input_stream.rewind

          Cli.new(io_streams: io_streams).start

          expect(output_stream.string).to match /199/i
        end

        it "works with input on separate lines" do
          input_stream.puts "2", "3", "+", "q"
          input_stream.rewind

          Cli.new(io_streams: io_streams).start

          expect(output_stream.string).to match /5/
        end
      end
    end
  end
end
