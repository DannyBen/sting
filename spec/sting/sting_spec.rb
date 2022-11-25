require 'spec_helper'

describe Sting do
  subject { described_class.new file1 }

  let(:dir)   { 'spec/fixtures' }
  let(:file1) { 'spec/fixtures/one' }
  let(:file2) { 'spec/fixtures/two' }
  let(:file3) { 'spec/fixtures/three' }

  describe '#initialize' do
    context 'with a source argument' do
      it 'adds the source' do
        expect(subject.some_key).to eq 'some_value'
      end
    end

    context 'without a source argument' do
      before { subject.reset! }

      it 'does not error' do
        expect(subject.settings).to eq({})
      end
    end
  end

  describe '<<' do
    context 'with a string filename argument' do
      it 'loads a YAML file' do
        expect(subject.some_key).to eq 'some_value'
      end

      it 'merges additional files' do
        expect(subject.filename).to eq 'one'
        subject << file2
        expect(subject.filename).to eq 'two'
        expect(subject.some_key).to eq 'some_value'
      end
    end

    context 'with a string directory argument' do
      subject { described_class.new }

      it 'loads all direct YAML files from the directory' do
        subject << dir
        expect(subject.filename).to eq 'two'
        expect(subject.some_key).to eq 'some_value'
      end
    end

    context 'with a string directory argument that has a glob' do
      subject { described_class.new }

      it 'loads all YAML files from the directory recursively' do
        subject << "#{dir}/**/*.yml"
        expect(subject.filename).to eq 'two'
        expect(subject.some_key).to eq 'some_value'
        expect(subject.grand_parent).to be true
      end
    end

    context 'with a hash argument' do
      it 'merges the new keys' do
        subject << { filename: 'two', another_key: 'another_value' }
        expect(subject.filename).to eq 'two'
        expect(subject.some_key).to eq 'some_value'
        expect(subject.another_key).to eq 'another_value'
      end
    end
  end

  describe '[]' do
    context 'with a symbol' do
      it 'returns a value' do
        expect(subject[:filename]).to eq subject.filename
      end
    end

    context 'with a string' do
      it 'returns a value' do
        expect(subject['filename']).to eq subject.filename
      end
    end

    context 'with multiple symbols or strings' do
      before { subject << file3 }

      it 'returns a deep (dig) value' do
        expect(subject[:some, :nested, :configuration]).to eq 'works'
      end

      context 'when the nested value does not exist' do
        it 'returns nil' do
          expect(subject[:some, :broken, :configuration]).to be_nil
        end
      end
    end

    context 'when the key does not exist' do
      it 'returns nil' do
        expect(subject['no-such-key']).to be_nil
      end
    end
  end

  describe 'has_key?' do
    context 'when key exists' do
      it 'returns true' do
        expect(subject.has_key? :filename).to be true
      end
    end

    context 'when key does not exist' do
      it 'returns false' do
        expect(subject.has_key? :no_key).to be false
      end
    end
  end

  describe 'settings' do
    it 'returns theh entire settings hash' do
      expect(subject.settings).to eq({ 'filename' => 'one', 'some_key' => 'some_value' })
    end
  end

  describe 'to_h' do
    it 'returns theh entire settings hash' do
      expect(subject.to_h).to eq({ 'filename' => 'one', 'some_key' => 'some_value' })
    end
  end

  describe 'method_missing' do
    it 'returns a value' do
      expect(subject.filename).to eq 'one'
    end

    context 'when the key does not exist' do
      it 'returns nil' do
        expect(subject.not_found).to be_nil
      end
    end
  end

  describe 'method_missing=' do
    it 'assigns a new value' do
      subject.new_key = 'new value'
      expect(subject.new_key).to eq 'new value'
    end
  end

  describe 'method_missing?' do
    context 'when the key exists' do
      it 'returns true' do
        expect(subject.filename?).to be true
      end
    end

    context 'when the key does not exists' do
      it 'returns false' do
        expect(subject.nokey?).to be false
      end
    end
  end

  describe 'method_missing!' do
    context 'when the key exists' do
      it 'returns its value' do
        expect(subject.filename!).to eq 'one'
      end
    end

    context 'when the key does not exists' do
      it 'raises ArgumentError' do
        expect { subject.nokey! }.to raise_error(ArgumentError)
      end
    end
  end

  context 'when using ExtendedYAML#extends' do
    subject { described_class.new 'spec/fixtures/extends/child.yml' }

    it 'extends the other files' do
      expect(subject.to_yaml).to match_approval('extends')
    end
  end
end
