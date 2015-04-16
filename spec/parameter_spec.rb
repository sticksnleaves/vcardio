require 'spec_helper'

describe VCardio::Parameter do
  describe 'to_abnf' do
    it 'should convert parameter with array value into ABNF' do
      abnf  = 'TYPE=WORK,HOME'
      param = VCardio::Parameter.new('type', %w(WORK HOME))

      expect(param.to_abnf(:rfc2426)).to eq(abnf)
    end

    it 'should convert parameter with string value into ABNF' do
      abnf  = 'TYPE=WORK'
      param = VCardio::Parameter.new('type', 'WORK')

      expect(param.to_abnf(:rfc2426)).to eq(abnf)
    end
  end

  describe '==' do
    it 'should equate identical instances' do
      param_1 = VCardio::Parameter.new('type', %w(WORK HOME))
      param_2 = VCardio::Parameter.new('type', %w(WORK HOME))

      expect(param_1).to eq(param_2)
    end

    it 'should not equate instances that are not identical' do
      param_1 = VCardio::Parameter.new('type', %w(WORK HOME))
      param_2 = VCardio::Parameter.new('type', %w(WORK))

      expect(param_1).to_not eq(param_2)
    end

    it 'should not equate objects that are not of the same type' do
      param_1 = VCardio::Parameter.new('type', %w(WORK HOME))
      param_2 = 'WORK'

      expect(param_1).to_not eq(param_2)
    end
  end
end
