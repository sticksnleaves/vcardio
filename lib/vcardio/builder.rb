module VCardio
  class Builder
    def initialize
      @builders   = []
    end

    def method_missing(method_name, *args)
      return super if respond_to?(method_name)
      builder = PropertyBuilder.new(method_name, args)
      @builders << builder
      builder
    end

    def properties
      properties = []

      @builders.each do |builder|
        properties << builder.to_property
      end

      properties
    end

    def self.call(&block)
      instance = new
      instance.instance_eval(&block)
      instance
    end

    class PropertyBuilder
      def initialize(name, args)
        @args  = args
        @group = nil
        @name  = name
      end

      def build_parameters(hash)
        hash ||= {}
        parameters = []

        hash.each do |k, v|
          parameters << VCardio::Parameter.new(k, v)
        end

        parameters
      end

      def to_property
        args       = @args.clone
        value      = args.shift
        parameters = build_parameters(args[0])

        VCardio::Property.new(@group, @name, parameters, value)
      end

      def method_missing(method_name, *args)
        @group = @name
        @name  = method_name
        @args  = args
        self
      end
    end
  end
end
