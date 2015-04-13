module VCardio
  class VCard
    def initialize(properties)
      @properties = properties || []
    end

    attr_reader :properties

    def ==(other)
      other.is_a?(VCardio::VCard) &&
        other.properties == properties
    end
  end
end
