require "sinatra/base"
require "sinatra/sugar"
require "yaml"

module Sinatra
  module ConfigFile
    def self.registered(klass)
      klass.register Sugar
    end

    def config_file(*paths)
      paths.each do |pattern|
        files = root_glob(pattern.to_s)
        files.each { |f| YAML.load_file(f).each_pair { |k,v| set k, v unless methods(false).any? { |m| m.to_s = k.to_s } } }
        warn "WARNING: could not load config file #{pattern}" if files.empty?
      end
    end
  end

  register ConfigFile

end