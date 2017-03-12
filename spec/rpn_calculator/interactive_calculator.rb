require 'spec_helper'

module RpnCalculator
  RSpec.describe InteractiveCalculator do
    let(:output_stream) { StringIO.new }
    let(:input_stream) { StringIO.new }

    describe "::start" do
      describe "commands" do
        it "q command quits with a message" do
          input_stream.puts "q"
          input_stream.rewind

          InteractiveCalculator.start(input_stream, output_stream)

          expect(output_stream.string).to match /goodbye/i
        end

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
            expect(output_stream.string).to match /goodbye/i
          end

          it "works with many numbers" do
            expected = (1..100).reduce :+

            input_stream.print (1..100).reduce('') { |acc, val| "#{acc} #{val}" }
            input_stream.puts " + q"
            input_stream.rewind

            InteractiveCalculator.start(input_stream, output_stream)
            expect(output_stream.string).to match /#{expected}/i
          end

          it "works with input on separate lines" do
            input_stream.puts "1", "2", "3", "+", "q"
            input_stream.rewind

            InteractiveCalculator.start(input_stream, output_stream)
            expect(output_stream.string).to match /6/
          end
        end
      end
    end
  end
end
