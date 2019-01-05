require 'spec_helper'

describe Sting do
  subject { described_class }

  it "behaves as a Sting instance" do
    instance_methods = subject.new.methods - Object.methods
    class_methods    = subject.methods - Object.methods

    expect(instance_methods).to eq class_methods
  end
end