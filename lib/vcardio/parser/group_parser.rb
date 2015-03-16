module VCardio
  module Parser
    #
    # @private
    #
    class GroupParser
      def self.call(part)
        separator_index = part.index('.')

        if separator_index
          group = part[0, separator_index] if separator_index

          VCardio::Validator::GroupValidator.call(group)

          group
        end
      end
    end
  end
end
