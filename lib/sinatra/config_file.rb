require 'sinatra/base'

module Sinatra
  module ConfigFile
    Parser = begin
      require 'psych'
      Psych
    rescue LoadError
      require 'yaml'
      YAML
    end unless defined? Parser

    def config_file(*paths)
      files = paths.map do |pattern|
        Dir[pattern].tap do |match|
          if match.empty?
            warn "WARNING: could not load config file #{pattern}"
          end
        end
      end.flatten.sort

      files.each do |file|
        yaml = Parser.load_file(file) || {}
        yaml.each_pair do |key, value|
          unless methods(false).include? key
            set key, value
          end
        end
      end
    end
  end

  register ConfigFile
end
