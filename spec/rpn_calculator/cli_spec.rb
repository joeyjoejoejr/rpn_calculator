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

    describe "::new" do
      it "initializes with the string lexer" do
        io_streams.argv = %w{-t string}

        cli = Cli.new(io_streams: io_streams)
        expect(cli.lexer).to be_a StringLexer
      end
    end

    describe "#start" do
      it "prints the help output" do
        io_streams.argv = %w{-h}

        expect(io_streams).not_to receive(:argf)
        Cli.new(io_streams: io_streams).start

        expect(output_stream.string).to match /help/
      end

      it "handles malformed input" do
        io_streams.argv = %w{--notanoption}

        expect {
          Cli.new(io_streams: io_streams).start
        }.to raise_error(Options::ParseError)

        expect(err_stream.string).to match /invalid option/
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

      describe "operators" do
        describe "+ operator" do
          it "adds queued numbers" do
            input_stream.puts "1 1 + q"
            input_stream.rewind

            Cli.new(io_streams: io_streams).start

            expect(output_stream.string).to match /2/
          end

          it "works with input on separate lines" do
            input_stream.puts "2", "3", "+", "q"
            input_stream.rewind

            Cli.new(io_streams: io_streams).start

            expect(output_stream.string).to match /5/
          end
        end

        describe "- operator" do
          it "subtracts numbers" do
            input_stream.puts "3 2 - q"
            input_stream.rewind

            Cli.new(io_streams: io_streams).start

            expect(output_stream.string).to match /1/
          end
        end

        describe "* operator" do
          it "multiplies numbers" do
            input_stream.puts "3 2 * q"
            input_stream.rewind

            Cli.new(io_streams: io_streams).start

            expect(output_stream.string).to match /6/
          end
        end

        describe "/ operator" do
          it "divides numbers" do
            input_stream.puts "3 2 / q"
            input_stream.rewind

            Cli.new(io_streams: io_streams).start

            expect(output_stream.string).to match /1\.5/
          end

          it "gives prints a message for division by zero" do
            input_stream.puts "3 0 / q"
            input_stream.rewind

            Cli.new(io_streams: io_streams).start

            expect(output_stream.string).to match /#{ZERO_DIVISION_MESSAGE}/
          end
        end
      end
    end
  end
end
