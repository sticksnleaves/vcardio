require 'spec_helper'

describe VCardio::Parser::ParamParser do
  it 'should parse params from contentline' do
    content_line = 'item1.TEL;type="WORK";type=pref:+1 617 555 1212'

    parts = content_line.split(':', 2)

    expect(
      VCardio::Parser::ParamParser.call(parts[0])
    ).to eq([%w(type WORK), %w(type pref)])
  end

  it 'should fail if param name is not 1*(ALPHA / DIGIT / "-")' do
    content_line = 'item1.TEL;ty_pe="WORK";type=pref:+1 617 555 1212'

    parts = content_line.split(':', 2)

    expect do
      VCardio::Parser::ParamParser.call(parts[0])
    end.to raise_error(VCardio::Error)
  end
end
