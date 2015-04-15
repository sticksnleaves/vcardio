module VCardio
  class VCard
    def initialize(version = '3.0', properties = [], &block)
      @properties = properties
      @version    = version

      builder(&block) if block_given?
    end

    attr_reader :properties, :version

    def spec
      if @version == '3.0'
        :rfc6350
      elsif @version == '4.0'
        :rfc2426
      end
    end

    def ==(other)
      other.is_a?(VCardio::VCard) &&
        other.properties == properties &&
        other.version    == version
    end

    private

    def builder(&block)
      builder = VCardio::Builder.call(&block)

      @properties.concat(builder.properties)
    end
  end
end
