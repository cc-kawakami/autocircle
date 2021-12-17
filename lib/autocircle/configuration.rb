module Autocircle
  class Configuration
    attr_accessor :main_lang,
                  :main_lang_version,
                  :variants,
                  :browser

    def initialize(params)
      @main_lang = params[:main_lang]
      @main_lang_version = params[:main_lang_version]
      @variants = params[:variants]
      @browser = params[:browser]
    end

    class << self

      #
      # @return [String]
      #
      def ruby_default_version
        "2.7.5"
      end

      #
      # @return [String]
      #
      def node_default_version
        "16.13.1"
      end
      
      #
      # @return [Hash]
      #
      def lang_options
        {
          "Ruby" => :ruby,
          "Node.js" => :node
        }
      end

      #
      # @return [Hash]
      #
      def variant_options
        {
          :ruby => {
            "Node.js" => :node,
            "Browser" => :browser
          },
          :node => {
            "Browser" => :browser
          }
        }
      end

      #
      # @return [Hash]
      #
      def browser_options
        {
          "Chrome" => :chrome,
          "Firefox" => :firefox,
          "Safari" => :safari
        }
      end
    end

    #
    # @return [Boolean]
    #
    def ruby_used?
      main_lang == :ruby
    end

    #
    # @return [Boolean]
    #
    def node_used?
      main_lang == :node || variants.include?(:node)
    end
  end
end
