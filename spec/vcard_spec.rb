require 'spec_helper'

describe VCardio::VCard do
  describe 'parse' do
    it 'should parse from a string' do
      vcard_entity = "BEGIN:VCARD\r\nVERSION:4.0\r\nFN:Smith;Anthony\r\nEND:VCARD"
      vcard = VCardio::VCard.new('4.0') do
        fn %w(Smith Anthony)
      end

      expect(VCardio::VCard.parse(vcard_entity)).to eq(vcard)
    end

    it 'should parse from a file' do
      vcard_file = File.open('spec/support/vcard.vcf')
      vcard = VCardio::VCard.new('4.0') do
        fn %w(Smith Anthony)
      end

      expect(VCardio::VCard.parse(vcard_file)).to eq(vcard)
    end

    it 'should fail if parsing from an unknown type' do
      expect do
        VCardio::VCard.parse(1)
      end.to raise_error(VCardio::Error, 'Could not parse. Expecting string or file.')
    end
  end

  describe 'separator' do
    it 'should return \n if spec is rfc2426' do
      vcard = VCardio::VCard.new('3.0')

      expect(vcard.separator).to eq("\n")
    end

    it 'should return \r\n if spec is rfc6350' do
      vcard = VCardio::VCard.new('4.0')

      expect(vcard.separator).to eq("\r\n")
    end
  end

  describe 'spec' do
    it 'should return rfc2426 if version is 3.0' do
      vcard = VCardio::VCard.new('3.0')

      expect(vcard.spec).to eq(:rfc2426)
    end

    it 'should return rfc6350 if version is 4.0' do
      vcard = VCardio::VCard.new('4.0')

      expect(vcard.spec).to eq(:rfc6350)
    end
  end

  describe 'to_abnf' do
    it 'should convert document into ABNF' do
      abnf  = "BEGIN:VCARD\nVERSION:3.0\nitem1.TEL;TYPE=WORK,HOME:5555555555\nEND:VCARD"
      vcard = VCardio::VCard.new { item1.tel '5555555555', type: %w(WORK HOME) }

      expect(vcard.to_abnf).to eq(abnf)
    end
  end

  describe '==' do
    it 'should equate identical instances' do
      properties = VCardio::Property.new(nil, 'TEL', nil, '5555555555')
      vcard1 = VCardio::VCard.new('3.0', properties)
      vcard2 = VCardio::VCard.new('3.0', properties)

      expect(vcard1).to eq(vcard2)
    end

    it 'should not equate instances that are not identical' do
      properties = VCardio::Property.new(nil, 'TEL', nil, '5555555555')
      vcard1 = VCardio::VCard.new('3.0', properties)
      vcard2 = VCardio::VCard.new('4.0', properties)

      expect(vcard1).to_not eq(vcard2)
    end

    it 'should not equate instances that are not of the same type' do
      properties = VCardio::Property.new(nil, 'TEL', nil, '5555555555')
      vcard1 = VCardio::VCard.new('3.0', properties)

      expect(vcard1).to_not eq('fail')
    end
  end
end
