module VCardio
  module Validator
    #
    # Name definition:
    #   "SOURCE" / "KIND" / "FN" / "N" / "NICKNAME"
    #   / "PHOTO" / "BDAY" / "ANNIVERSARY" / "GENDER" / "ADR" / "TEL"
    #   / "EMAIL" / "IMPP" / "LANG" / "TZ" / "GEO" / "TITLE" / "ROLE"
    #   / "LOGO" / "ORG" / "MEMBER" / "RELATED" / "CATEGORIES"
    #   / "NOTE" / "PRODID" / "REV" / "SOUND" / "UID" / "CLIENTPIDMAP"
    #   / "URL" / "KEY" / "FBURL" / "CALADRURI" / "CALURI" / "XML"
    #   / iana-token / x-name
    #
    # Although the name definition has a long list of possible values the
    # `iana-token` pattern is the least common denominator. It basically allows
    # `name` to match anything that follows the `1*(ALPHA / DIGIT / "-")`
    # pattern. Therefore that's all we validate against.
    #
    # @private
    #
    class NameValidator
      def self.call(name)
        if /\A[A-Za-z\d-]*\z/.match(name).nil?
          fail VCardio::Error, "Invalid name: #{name}"
        end
      end
    end
  end
end
