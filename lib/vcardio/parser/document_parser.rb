module VCardio
  module Parser
    #
    # @private
    #
    class DocumentParser
      def self.call(vcard)
        document = split_properties(vcard)

        VCardio::Validator::VCardValidator.call(document)

        properties = parse_properties(document)

        VCardio::VCard.new(properties)
      end

      # Unfold on CRLF + whitespace and split on CRLF or LF.
      def self.split_properties(vcard)
        unfolded_vcard = Manilla.unfold(vcard, "\r\n\s")
        unfolded_vcard.split(/\r\n|\\n(?<!\\\\n)/)
      end
      private_class_method :split_properties

      # Parse document array into property list.
      def self.parse_properties(document)
        properties = []

        document.each do |line|
          property = VCardio::Parser::LineParser.call(line)

          # Don't include BEGIN:VCARD and END:VCARD in property list
          if (property.name == 'BEGIN' || property.name == 'END') && property.value == 'VCARD'
            next
          end

          properties << property
        end

        properties
      end
      private_class_method :split_properties
    end
  end
end
