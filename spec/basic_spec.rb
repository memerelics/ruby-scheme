require 'spec_helper'

describe Anfinsen::Basic do
  let(:world) { Object.new.extend Anfinsen::Basic }

  describe '#parse' do
    it { world.parse('+ 1 2').must_equal ['+', '1', '2'] }
  end

  describe '#apply_primitive' do
    it { world.apply_primitive('+', ['1', '2']).must_equal 3 }
    it { world.apply_primitive('+', ['1', '2', '3']).must_equal 6 }
  end

  describe '#eval' do
    it { world.eval('+ 1 2').must_equal 3 }
    it { world.eval('- 1 2').must_equal -1 }
  end
end
