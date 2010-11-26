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

    def self.registered(klass)
      klass.register Sugar
    end

    def config_file(*paths)
      paths.each do |pattern|
        files = root_glob(pattern.to_s).to_a
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

  register ConfigFile
end
