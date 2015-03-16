module VCardio
  module Parser
    #
    # @private
    #
    class LineParser
      def self.call(content_line)
        parts = content_line.split(':', 2)

        group  = VCardio::Parser::GroupParser.call(parts[0])
        name   = VCardio::Parser::NameParser.call(parts[0])
        params = VCardio::Parser::ParamParser.call(parts[0])

        VCardio::Property.new(group, name, params, nil)
      end
    end
  end
end
