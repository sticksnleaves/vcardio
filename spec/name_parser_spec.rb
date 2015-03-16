require 'spec_helper'

describe VCardio::Parser::NameParser do
  it 'should parse name from contentline' do
    expect(
      VCardio::Parser::NameParser.call(
        'item1.TEL;type=WORK;type=pref:+1 617 555 1212'
      )
    ).to eq('TEL')
  end

  it 'should fail if name is not 1*(ALPHA / DIGIT / "-")' do
    expect do
      VCardio::Parser::NameParser.call(
        'item1.TEL_PHONE;type=WORK;type=pref:+1 617 555 1212'
      )
    end.to raise_error(VCardio::Error)
  end
end
