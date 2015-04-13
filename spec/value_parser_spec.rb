require 'spec_helper'

describe VCardio::Parser::ValueParser do
  it 'should parse a non-delimited value as a string' do
    expect(VCardio::Parser::ValueParser.call('Anthony')).to eq('Anthony')
  end

  it 'should parse a semi-colon delimited value as an array' do
    expect(VCardio::Parser::ValueParser.call('Smith;Anthony')).to eq(['Smith', 'Anthony'])
  end

  it 'should parse an escaped semi-colon-ed value as a string' do
    expect(VCardio::Parser::ValueParser.call('Smith\;Anthony')).to eq('Smith\;Anthony')
  end

  it 'should parse a semi-color delimited value with an escaped semi-colon-ed value as an array' do
    expect(VCardio::Parser::ValueParser.call('Smith\;Anthony;Tony')).to eq(['Smith\;Anthony', 'Tony'])
  end
end
