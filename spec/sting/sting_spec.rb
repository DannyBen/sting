require 'spec_helper'

describe Sting do
  before { Sting.reset! }
  let(:file1) { 'spec/fixtures/one' }
  let(:file2) { 'spec/fixtures/two' }

  describe '<<' do
    it "loads a YAML file" do
      Sting << file1
      expect(Sting.some_key).to eq 'some_value'
    end

    it "merges additional files" do
      Sting << file1
      expect(Sting.filename).to eq 'one'      
      Sting << file2
      expect(Sting.filename).to eq 'two'
      expect(Sting.some_key).to eq 'some_value'
    end
  end

  describe '[]' do
    before { Sting << file1 }

    it "returns a value" do
      expect(Sting[:filename]).to eq Sting.filename      
    end
  end

  describe 'has_key?' do
    before { Sting << file1 }

    context "when key exists" do
      it "returns true" do
        expect(Sting.has_key? :filename).to be true
      end
    end

    context "when key does not exist" do
      it "returns false" do
        expect(Sting.has_key? :no_key).to be false
      end
    end
  end
end
