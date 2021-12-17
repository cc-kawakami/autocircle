require "thor"
require "tty-prompt"
require_relative "./interactor"

module Autocircle
  class CLI < Thor
    desc "generate", "Generate Circle CI configuration"
    def generate
      prompt = TTY::Prompt.new

      interactor = Interactor.new

      input = {}

      input[:main_lang] = prompt.select("? Select main language:", interactor.config.lang_options)

      input[:main_lang_version] = prompt.ask(
        "? What #{input[:main_lang]} version?:",
        default: interactor.config.send("#{input[:main_lang]}_default_version")
      )

      if input[:main_lang] == :ruby
        input[:variants] = prompt.multi_select("? Do you use variant?:", interactor.config.variant_options[input[:main_lang]])
      end

      if prompt.yes?("? Do you do browser EtoE test?")
        input[:browser] = prompt.select("? Select browser:", interactor.config.browser_options)
      end

      Interactor.new.call(input)

      puts "✔︎ .circleci/config.yml is generated!"
    end
  end
end
