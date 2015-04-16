require 'spec_helper'

describe VCardio::Property do
  describe 'to_abnf' do
    it 'should convert property with string value into ABNF' do
      abnf = 'FN:Anthony'
      prop = VCardio::Property.new(nil, 'FN', nil, 'Anthony')

      expect(prop.to_abnf(:rfc2426)).to eq(abnf)
    end

    it 'should convert property with array value into ABNF' do
      abnf = 'FN:Smith;Anthony'
      prop = VCardio::Property.new(nil, 'FN', nil, %w(Smith Anthony))

      expect(prop.to_abnf(:rfc2426)).to eq(abnf)
    end

    it 'should convert property with group into ABNF' do
      abnf = 'item1.FN:Smith;Anthony'
      prop = VCardio::Property.new('item1', 'FN', nil, %w(Smith Anthony))

      expect(prop.to_abnf(:rfc2426)).to eq(abnf)
    end

    it 'should convert property with parameters into ABNF' do
      abnf  = 'TEL;TYPE=WORK,HOME:5555555555'
      params = [VCardio::Parameter.new('type', %w(WORK HOME))]
      prop  = VCardio::Property.new(nil, 'TEL', params, '5555555555')

      expect(prop.to_abnf(:rfc2426)).to eq(abnf)
    end
  end

  describe '==' do
    it 'should equate identical instances' do
      params = [VCardio::Parameter.new('type', %w(WORK HOME))]
      prop_1 = VCardio::Property.new('item1', 'FN', params, %w(Smith Anthony))
      prop_2 = VCardio::Property.new('item1', 'FN', params, %w(Smith Anthony))

      expect(prop_1).to eq(prop_2)
    end

    it 'should not equate instances that are not identical' do
      params = [VCardio::Parameter.new('type', %w(WORK HOME))]
      prop_1 = VCardio::Property.new('item1', 'ORG', params, 'Sticksnleaves')
      prop_2 = VCardio::Property.new('item1', 'FN', params, %w(Smith Anthony))

      expect(prop_1).to_not eq(prop_2)
    end

    it 'should not equate objects that are not of the same type' do
      params = [VCardio::Parameter.new('type', %w(WORK HOME))]
      prop_1 = VCardio::Property.new('item1', 'ORG', params, 'Sticksnleaves')
      prop_2 = 'Smith Anthony'

      expect(prop_1).to_not eq(prop_2)
    end
  end
end
