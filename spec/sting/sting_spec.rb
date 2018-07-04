require 'spec_helper'

describe Sting do
  subject { described_class }

  let(:file1) { 'spec/fixtures/one' }
  let(:file2) { 'spec/fixtures/two' }

  before { subject.reset!; subject << file1 }

  describe '<<' do
    context "with a string argument" do
      it "loads a YAML file" do
        expect(subject.some_key).to eq 'some_value'
      end

      it "merges additional files" do
        expect(subject.filename).to eq 'one'      
        subject << file2
        expect(subject.filename).to eq 'two'
        expect(subject.some_key).to eq 'some_value'
      end
    end

    context "with a hash argument" do
      it "merges the new keys" do
        subject << { filename: 'two', another_key: 'another_value' }
        expect(subject.filename).to eq 'two'
        expect(subject.some_key).to eq 'some_value'
        expect(subject.another_key).to eq 'another_value'
      end
    end
  end

  describe 'method_missing' do
    it "returns a value" do
      expect(subject.filename).to eq 'one'
    end
  end

  describe 'method_missing=' do
    it "assigns a new value" do
      subject.new_key = 'new value'
      expect(subject.new_key).to eq 'new value'
    end
  end

  describe 'method_missing?' do
    context "when the key exists" do
      it "returns true" do
        expect(subject.filename?).to be true
      end
    end

    context "when the key does not exists" do
      it "returns false" do
        expect(subject.nokey?).to be false
      end
    end
  end

  describe 'method_missing!' do
    context "when the key exists" do
      it "returns its value" do
        expect(subject.filename!).to eq 'one'
      end
    end

    context "when the key does not exists" do
      it "raises ArgumentError" do
        expect{ subject.nokey! }.to raise_error(ArgumentError)
      end
    end
  end


  describe '[]' do
    it "returns a value" do
      expect(subject[:filename]).to eq subject.filename      
    end
  end

  describe 'has_key?' do
    context "when key exists" do
      it "returns true" do
        expect(subject.has_key? :filename).to be true
      end
    end

    context "when key does not exist" do
      it "returns false" do
        expect(subject.has_key? :no_key).to be false
      end
    end
  end
end
