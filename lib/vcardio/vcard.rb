module VCardio
  class VCard
    def initialize(properties = [], &block)
      @properties = properties

      builder(&block) if block_given?
    end

    attr_reader :properties

    def ==(other)
      other.is_a?(VCardio::VCard) &&
        other.properties == properties
    end

    private

    def builder(&block)
      builder = VCardio::Builder.call(&block)

      @properties.concat(builder.properties)
    end
  end
end
