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
      @group = group
      @name = name.to_s.upcase
      @parameters = parameters || []
      @value = value
    end

    attr_reader :group, :name, :parameters, :value

    def ==(other)
      other.is_a?(VCardio::Property) &&
        other.group == group &&
        other.name == name &&
        other.parameters == parameters &&
        other.value == value
    end
  end
end
