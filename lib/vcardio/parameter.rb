module VCardio
  #
  # Name/value parameter pair of a content line definition.
  #
  # Given the content line:
  #   `item1.TEL;type=WORK,HOME:+1 617 555 1212`
  #
  # The parameter name will be `type` and value will be `['WORK', 'HOME']`.
  #
  # @attr_reader [String] name
  # @attr_reader [String,Array] value
  #
  class Parameter
    def initialize(name, value)
      @name = name
      @value = value
    end

    attr_reader :name, :value

    def ==(other)
      other.is_a?(VCardio::Parameter) &&
        name == other.name &&
        value == other.value
    end
  end
end
