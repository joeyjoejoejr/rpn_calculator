require 'spec_helper'

module RpnCalculator
  RSpec.describe InteractiveCalculator do
    let(:output_stream) { StringIO.new }
    let(:input_stream) { StringIO.new }

    describe "::start" do
      describe "formatting" do
        it "shows a prompt on each line" do
          input_stream.puts "q"
          input_stream.rewind

          InteractiveCalculator.start(input_stream, output_stream)

          expect(output_stream.string).to match /#{InteractiveCalculator::PROMPT_MESSAGE}/
        end

        it "echoes the input" do
          input_stream.puts "10 q"
          input_stream.rewind

          InteractiveCalculator.start(input_stream, output_stream)

          expect(output_stream.string).to match /10/
        end

        it "shows the quitting message" do
          input_stream.puts "q"
          input_stream.rewind

          InteractiveCalculator.start(input_stream, output_stream)

          expect(output_stream.string).to match /#{InteractiveCalculator::GOODBYE_MESSAGE}/i
        end
      end

      describe "commands" do
        describe "+ command" do
          it "adds queued numbers" do
            input_stream.puts "1 1 + q"
            input_stream.rewind

            InteractiveCalculator.start(input_stream, output_stream)

            expect(output_stream.string).to match /2/
          end

          it "adds queued negative numbers" do
            input_stream.puts "-1 -1 + q"
            input_stream.rewind

            InteractiveCalculator.start(input_stream, output_stream)
            expect(output_stream.string).to match /-2/
          end

          it "works with no numbers" do
            input_stream.puts "+ q"
            input_stream.rewind

            InteractiveCalculator.start(input_stream, output_stream)
            expect { output_stream.string }.not_to raise_error
          end

          it "only operates on the last two numbers" do
            input_stream.print (1..100).reduce('') { |acc, val| "#{acc} #{val}" }
            input_stream.puts " + q"
            input_stream.rewind

            InteractiveCalculator.start(input_stream, output_stream)
            expect(output_stream.string).to match /199/i
          end

          it "works with input on separate lines" do
            input_stream.puts "2", "3", "+", "q"
            input_stream.rewind

            InteractiveCalculator.start(input_stream, output_stream)
            expect(output_stream.string).to match /5/
          end
        end
      end
    end
  end
end
