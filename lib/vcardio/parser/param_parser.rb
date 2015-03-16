module VCardio
  module Parser
    #
    # @private
    #
    class ParamParser
      def self.call(part)
        values = []
        name_end_index = part.index(';')

        if name_end_index
          params = part[name_end_index + 1, part.length].split(';')

          values = compose_values(params)
        end

        values
      end

      #
      # Join param name/value pair into an array. Strip out DQUOTE. Split param
      # value if comma separated.
      #
      def self.compose_param(name, value)
        value = value.gsub(/"/, '')
        value = value.split(',') if value.index(',')

        VCardio::Parameter.new(name, value)
      end
      private_class_method :compose_param

      #
      # Join all param name/value pairs into a multi-dimensional array.
      #
      def self.compose_values(params)
        values = []

        params.each do |param|
          parts = param.split('=', 2)

          VCardio::Validator::ParamNameValidator.call(parts[0])

          values << compose_param(parts[0], parts[1])
        end

        values
      end
      private_class_method :compose_values
    end
  end
end
