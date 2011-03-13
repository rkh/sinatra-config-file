require 'sinatra/base'

module Sinatra
  module ConfigFile
    unless defined? Parser
      begin
        require "psych"
        Parser = Psych
      rescue LoadError
        require "yaml"
        Parser = YAML
      end
    end

    def config_file(*paths)
      Dir.chdir root do
        paths.each do |pattern|
          files = Dir.glob pattern
          files.each do |file|
            yaml = Parser.load_file(file) || {}
            yaml.each_pair do |key, value|
              set key, value unless methods(false).any? { |m| m.to_s == key.to_s }
            end
          end
          warn "WARNING: could not load config file #{pattern}" if files.empty?
        end
      end
    end
  end

  register ConfigFile
end
