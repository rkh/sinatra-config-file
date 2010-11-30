require 'sinatra/base'
require 'pathname'

class String
  def expand_path
    Pathname(self).expand_path.to_s
  end

  def file_join(other)
    Pathname(self).join(other.to_s).to_s
  end
  alias / file_join
end

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

    def root_path(*args)
      relative = File.join(*args)
      return relative if relative.expand_path == relative
      root.expand_path / relative
    end

    def root_glob(*args, &block)
      Dir.glob(root_path(*args)).each(&block)
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
