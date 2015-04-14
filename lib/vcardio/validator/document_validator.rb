module VCardio
  module Validator
    #
    # @private
    #
    class DocumentValidator
      def self.call(document)
        lines = document.reject(&:empty?)

        begin_vcard = false
        end_vcard = false
        fn = false
        version = false

        lines.each_with_index do |line, i|
          if i == 0 && /\ABEGIN:VCARD\z/.match(line)
            begin_vcard = true
          elsif (i == lines.size - 1) && /\AEND:VCARD\z/.match(line)
            end_vcard = true
          elsif /\AFN:/.match(line)
            fn = true
          elsif i == 1 && /\AVERSION:(3.0|4.0)\z/.match(line)
            version = true
          end
        end

        fail(VCardio::Error, 'Invalid vCard: First line must be BEGIN:VCARD') unless begin_vcard
        fail(VCardio::Error, 'Invalid vCard: Last line must be END:VCARD') unless end_vcard
        fail(VCardio::Error, 'Invalid vCard: Second line must be VERSION with value 3.0 or 4.0') unless version
        fail(VCardio::Error, 'Invalid vCard: Must contain the FN property') unless fn
      end
    end
  end
end
