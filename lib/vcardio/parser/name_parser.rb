module VCardio
  module Parser
    #
    # @private
    #
    class NameParser
      def self.call(part)
        group_end_index = part.index('.')
        group_sep_index = group_end_index ? group_end_index + 1 : 0
        line_end_index = (part.index(';') || part.length) - group_sep_index

        name = part[group_sep_index, line_end_index]

        VCardio::Validator::NameValidator.call(name)

        name
      end
    end
  end
end
