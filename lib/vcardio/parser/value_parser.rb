module VCardio
  module Parser
    #
    # @private
    #
    class ValueParser
      def self.call(part)
        value = part.split(/;(?<!\\;)/, -1)
        value.length > 1 ? value : value[0]
      end
    end
  end
end
