module VCardio
  module Validator
    class VCardValidator
      def self.call(vcard)
        validate_begin(vcard)
        validate_end(vcard)
        validate_fn(vcard)
        validate_version(vcard)
      end

      def self.validate_begin(vcard)
        if /\ABEGIN:VCARD\z/.match(vcard[0]).nil?
          fail(VCardio::Error, 'Invalid vCard: First line must be BEGIN:VCARD')
        end
      end
      private_class_method :validate_begin

      def self.validate_end(vcard)
        lines = vcard.reject(&:empty?).reverse

        lines.each do |line|
          if /\AEND:VCARD\z/.match(line).nil?
            fail(VCardio::Error, 'Invalid vCard: Last line must be END:VCARD')
          else
            break
          end
        end
      end
      private_class_method :validate_end

      def self.validate_fn(vcard)
        fn_found = false

        vcard.each do |line|
          if /\AFN:/.match(line)
            fn_found = true
            break
          end
        end

        fail(VCardio::Error, 'Invalid vCard: Must contain the FN property') unless fn_found
      end

      def self.validate_version(vcard)
        if /\AVERSION:(3.0|4.0)\z/.match(vcard[1]).nil?
          fail(
            VCardio::Error,
            'Invalid vCard: Second line must be VERSION with value 3.0 or 4.0'
          )
        end
      end
      private_class_method :validate_version
    end
  end
end
