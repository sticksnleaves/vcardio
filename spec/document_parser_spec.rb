require 'spec_helper'

describe VCardio::Parser::DocumentParser do
  it 'should parse properties from vCard entity' do
    vcard_entity = "BEGIN:VCARD\r\nVERSION:4.0\r\nFN:Smith;Anthony\r\nEND:VCARD"
    properties = [
      VCardio::Property.new(nil, 'VERSION', nil, '4.0'),
      VCardio::Property.new(nil, 'FN', nil, %w(Smith Anthony))
    ]
    vcard = VCardio::VCard.new(properties)

    expect(VCardio::Parser::DocumentParser.call(vcard_entity)).to eq(vcard)
  end

  it 'should fail if vCard does not start with BEGIN:VCARD' do
    vcard_entity = "VERSION:4.0\r\nBEGIN:VCARD"

    expect do
      VCardio::Parser::DocumentParser.call(vcard_entity)
    end.to raise_error(VCardio::Error, 'Invalid vCard: First line must be BEGIN:VCARD')
  end

  it 'should fail if vCard does not end with END:VCARD' do
    vcard_entity = "BEGIN:VCARD\r\nEND:VCARD\r\nVERSION:4.0"

    expect do
      VCardio::Parser::DocumentParser.call(vcard_entity)
    end.to raise_error(VCardio::Error, 'Invalid vCard: Last line must be END:VCARD')
  end

  it 'should ignore empty lines' do
    vcard_entity = "BEGIN:VCARD\r\nVERSION:4.0\r\nFN:Smith;Anthony\r\nEND:VCARD\r\n\r\n"

    expect do
      VCardio::Parser::DocumentParser.call(vcard_entity)
    end.to_not raise_error
  end

  it 'should fail if vCard does not contain the VERSION property' do
    vcard_entity = "BEGIN:VCARD\r\nFN:Smith;Anthony\r\nEND:VCARD"

    expect do
      VCardio::Parser::DocumentParser.call(vcard_entity)
    end.to raise_error(VCardio::Error, 'Invalid vCard: Second line must be VERSION with value 3.0 or 4.0')
  end

  it 'should fail if vCard does not contain VERSION as second property' do
    vcard_entity = "BEGIN:VCARD\r\nFN:Smith;Anthony\r\nVERSION:4.0\r\nEND:VCARD"

    expect do
      VCardio::Parser::DocumentParser.call(vcard_entity)
    end.to raise_error(VCardio::Error, 'Invalid vCard: Second line must be VERSION with value 3.0 or 4.0')
  end

  it 'should fail if vCard does not contain the FN property' do
    vcard_entity = "BEGIN:VCARD\r\nVERSION:4.0\r\nEND:VCARD"

    expect do
      VCardio::Parser::DocumentParser.call(vcard_entity)
    end.to raise_error(VCardio::Error, 'Invalid vCard: Must contain the FN property')
  end
end
