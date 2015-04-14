require 'spec_helper'

describe VCardio::Builder do
  it 'should build a vCard property list' do
    properties = [VCardio::Property.new(nil, :tel, nil, '5555555555')]
    document = VCardio::VCard.new(properties)

    expect(VCardio::VCard.new { tel '5555555555' }).to eq(document)
  end

  it 'should build a vCard property list with parameters' do
    parameter = VCardio::Parameter.new(:pref, 1)
    property = VCardio::Property.new(nil, :tel, [parameter], '5555555555')
    document = VCardio::VCard.new([property])

    expect(VCardio::VCard.new { tel '5555555555', pref: 1 }).to eq(document)
  end

  it 'should support multiple properties' do
    properties = [
      VCardio::Property.new(nil, :tel, nil, '5555555555'),
      VCardio::Property.new(nil, :adr, nil, [nil, nil, '7 Launch Way', 'Fishers', 'IN', '46038'])
    ]
    document = VCardio::VCard.new(properties)

    expect(
      VCardio::VCard.new do
        tel '5555555555'
        adr [nil, nil, '7 Launch Way', 'Fishers', 'IN', '46038']
      end
    ).to eq(document)
  end

  it 'should support multiple properties of the same type' do
    properties = [
      VCardio::Property.new(nil, :tel, nil, '5555555555'),
      VCardio::Property.new(nil, :tel, nil, '5555555556')
    ]
    document = VCardio::VCard.new(properties)

    expect(
      VCardio::VCard.new do
        tel '5555555555'
        tel '5555555556'
      end
    ).to eq(document)
  end

  it 'should support groups' do
    properties = [VCardio::Property.new(:item1, :tel, nil, '5555555555')]
    document = VCardio::VCard.new(properties)

    expect(
      VCardio::VCard.new do
        item1.tel '5555555555'
      end
    ).to eq(document)
  end
end
