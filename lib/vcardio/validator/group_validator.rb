module VCardio
  module Validator
    #
    # Group definition:
    #   `1*(ALPHA / DIGIT / "-")`
    #
    # @private
    #
    class GroupValidator
      def self.call(group)
        if /\A[A-Za-z\d-]*\z/.match(group).nil?
          fail VCardio::Error, "Invalid group: #{group}"
        end
      end
    end
  end
end
