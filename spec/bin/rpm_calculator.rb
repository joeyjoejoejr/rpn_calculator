require 'spec_helper'

RSpec.describe "CLI Usage", type: :aruba do
  before(:each) { run('rpn_calculator -i') }

  it "adds two numbers" do
    type("1 1 + q")
    expect(last_command_started).to be_successfully_executed
    expect(last_command_started).to have_output_on_stdout /2/
  end

  it "handles interrupt" do
    last_command_started.send_signal 'SIGINT'
    expect(last_command_started).to have_output_on_stdout /exiting/i
  end
end
