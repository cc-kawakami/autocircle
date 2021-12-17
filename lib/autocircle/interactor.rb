require_relative "./configuration"
require_relative "./generator"

module Autocircle
  class Interactor
    attr_reader :config, :generator

    def initialize(
      config: Configuration,
      generator: Generator
    )
      @config = config
      @generator = generator
    end

    def call(input)
      @generator.new(@config.new(input)).create_config_file!
    end
  end
end
