module VCardio
  class VCard
    def initialize(version = '3.0', properties = [], &block)
      @properties = properties
      @version    = version

      builder(&block) if block_given?
    end

    attr_reader :properties, :version

    def get(property_name)
      @properties.select { |p| p.name == property_name.to_s.upcase }
    end

    def separator
      if spec == :rfc2426
        "\n"
      elsif spec == :rfc6350
        "\r\n"
      end
    end

    def spec
      if @version == '3.0'
        :rfc2426
      elsif @version == '4.0'
        :rfc6350
      end
    end

    def to_abnf
      abnf = []
      abnf << 'BEGIN:VCARD'
      abnf << "VERSION:#{version}"

      @properties.each do |property|
        abnf << "#{Manilla.fold(property.to_abnf(spec), 75, "\r\n\s")}"
      end

      abnf << 'END:VCARD'

      abnf.join(separator)
    end
    alias_method :to_s, :to_abnf

    def to_file(path)
      File.write(path, to_abnf)
    end

    def ==(other)
      other.is_a?(VCardio::VCard) &&
        other.properties == properties &&
        other.version    == version
    end

    def method_missing(method_name, *args, &block)
      return super if respond_to?(method_name)
      get(method_name)
    end

    def self.parse(file)
      if file.is_a?(String)
        VCardio::Parser::DocumentParser.call(file)
      elsif file.is_a?(File)
        VCardio::Parser::DocumentParser.call(file.read)
      else
        fail(VCardio::Error, 'Could not parse. Expecting string or file.')
      end
    end

    private

    def builder(&block)
      builder = VCardio::Builder.call(&block)

      @properties.concat(builder.properties)
    end
  end
end
