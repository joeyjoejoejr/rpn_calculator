require 'spec_helper'

RSpec.describe "CLI Usage", type: :aruba do
  describe "standard usage" do
    before(:each) { run 'rpn_calculator' }

    it "adds two numbers" do
      type("1 1 + q\n")
      expect(last_command_started).to be_successfully_executed
      expect(last_command_started).to have_output_on_stdout /2/
    end

    it "handles interrupt" do
      last_command_started.send_signal 'SIGINT'
      expect(last_command_started).to be_successfully_executed
    end

    it "gives user friendly repsonses" do
      type("0.1 0.2 + q\n")

      expect(last_command_started).to have_output_on_stdout /0\.3\b/
    end
  end

  describe "string calc usage" do
    before(:each) { run 'rpn_calculator -t string' }

    it "concats strings" do
      type("hello world !concat /q\n")

      expect(last_command_started).to have_output_on_stdout /helloworld/
    end
  end
end
