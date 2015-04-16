module VCardio
  #
  # Content line definition and value.
  #
  # @attr_reader [String] group
  # @attr_reader [String] name
  # @attr_reader [Array<VCardio::Parameter>] parameters
  # @attr_reader [String,Array] value
  #
  class Property
    def initialize(group, name, parameters, value)
      @group = group ? group.to_s : nil
      @name = name.to_s.upcase
      @parameters = parameters || []
      @value = value
    end

    attr_reader :group, :name, :parameters, :value

    def to_abnf(spec)
      abnf = @group || ''
      parameters = []
      abnf += '.' if @group
      abnf += @name

      @parameters.each do |parameter|
        parameters << parameter.to_abnf(spec)
      end

      abnf += parameters.size > 0 ? ';' : ''
      abnf += parameters.join(';')
      abnf += ':'
      abnf += @value.is_a?(Array) ? @value.join(';') : @value.to_s

      abnf
    end

    def ==(other)
      other.is_a?(VCardio::Property) &&
        other.group == group &&
        other.name == name &&
        other.parameters == parameters &&
        other.value == value
    end
  end
end
