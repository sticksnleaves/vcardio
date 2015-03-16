require 'spec_helper'

describe VCardio::Parser::GroupParser do
  it 'should parse group from contentline' do
    expect(
      VCardio::Parser::GroupParser.call(
        'item1.TEL;type=WORK;type=pref:+1 617 555 1212'
      )
    ).to eq('item1')
  end

  it 'should fail if group is not 1*(ALPHA / DIGIT / "-")' do
    expect do
      VCardio::Parser::GroupParser.call(
        'item_1.TEL;type=WORK;type=pref:+1 617 555 1212'
      )
    end.to raise_error(VCardio::Error)
  end
end
