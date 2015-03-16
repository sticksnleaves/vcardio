module VCardio
  module Validator
    #
    # Param name definition:
    #   language-param / value-param / pref-param / pid-param
    #   / type-param / geo-parameter / tz-parameter / sort-as-param
    #   / calscale-param / any-param
    #
    # Although the param name definition has a list of possible values the
    # `any-param` pattern (which includes the `iana-token`) pattern is the least
    # common denominator. It basically allows param name to match anything that
    # follows the `1*(ALPHA / DIGIT / "-")` pattern. Therefore that's all we
    # validate against.
    #
    # @private
    #
    class ParamNameValidator
      def self.call(param_name)
        if /\A[A-Za-z\d-]*\z/.match(param_name).nil?
          fail VCardio::Error, "Invalid parameter name: #{param_name}"
        end
      end
    end
  end
end
