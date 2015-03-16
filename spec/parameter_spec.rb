require 'spec_helper'

describe VCardio::Parameter do
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
