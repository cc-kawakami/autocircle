require "erb"

module Autocircle
  class Generator
    def initialize(config)
      @config = config
    end

    #
    # @return [void]
    #
    def create_config_file!
      Dir.mkdir(".circleci") unless Dir.exist?(".circleci")
      File.open(".circleci/config.yml", "w+") do |f|
        f.write(config_file_template.result(@config.instance_eval { binding }))
      end
    end

    #
    # @return [ERB]
    #
    def config_file_template
      ERB.new(File.read(__dir__ + "/templates/config.yml.erb"), nil, '-')
    end
  end
end
