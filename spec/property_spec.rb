require 'spec_helper'

describe VCardio::Property do
  describe '==' do
    it 'should equate identical instances' do
      params = VCardio::Parameter.new('type', %w(WORK HOME))
      prop_1 = VCardio::Property.new('item1', 'FN', params, %w(Smith Anthony))
      prop_2 = VCardio::Property.new('item1', 'FN', params, %w(Smith Anthony))

      expect(prop_1).to eq(prop_2)
    end

    it 'should not equate instances that are not identical' do
      params = VCardio::Parameter.new('type', %w(WORK HOME))
      prop_1 = VCardio::Property.new('item1', 'ORG', params, 'Sticksnleaves')
      prop_2 = VCardio::Property.new('item1', 'FN', params, %w(Smith Anthony))

      expect(prop_1).to_not eq(prop_2)
    end

    it 'should not equate objects that are not of the same type' do
      params = VCardio::Parameter.new('type', %w(WORK HOME))
      prop_1 = VCardio::Property.new('item1', 'ORG', params, 'Sticksnleaves')
      prop_2 = 'Smith Anthony'

      expect(prop_1).to_not eq(prop_2)
    end
  end
end
