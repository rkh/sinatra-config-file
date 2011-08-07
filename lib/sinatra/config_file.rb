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
      deep_merger = lambda { |h1, h2|
        h2.each_key { |k|
          if Hash === h1[k] and Hash === h2[k]
            deep_merger.call(h1[k], h2[k])
          else
            h1[k] = h2[k]
          end
        }
      }

      configs = [ ]

      Dir.chdir root do
        paths.each do |pattern|
          files = Dir.glob pattern
          files.each { |file| configs << Parser.load_file(file) || { } }
          warn "WARNING: could not load config file #{pattern}" if files.empty?
        end
      end

      settings = configs.shift
      configs.each { |config| deep_merger.call(settings, config) }

      settings.each_pair do |key, value|
        set key, value unless methods(false).any? { |m| m.to_s == key.to_s }
      end
    end
  end

  register ConfigFile
end
