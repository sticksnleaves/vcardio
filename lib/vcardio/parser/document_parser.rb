module VCardio
  module Parser
    #
    # @private
    #
    class DocumentParser
      def self.call(vcard)
        document = split_properties(vcard)

        VCardio::Validator::DocumentValidator.call(document)

        properties = parse_properties(document)
        version    = extract_version(properties)
        properties = clean_properties(properties)

        VCardio::VCard.new(version, properties)
      end

      def self.clean_properties(properties)
        properties.each.reject do |property|
          property.name == 'VERSION' ||
            ((property.name == 'BEGIN' ||
             property.name == 'END') &&
               property.value == 'VCARD')
        end
      end
      private_class_method :clean_properties

      def self.extract_version(properties)
        properties[1].value
      end
      private_class_method :extract_version

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

          properties << property
        end

        properties
      end
      private_class_method :parse_properties
    end
  end
end
