require 'florrick/version'
require 'florrick/builder'
require 'florrick/dsl'
require 'florrick/formatter'
require 'florrick/builtin_formatters'
require 'florrick/railtie' if defined?(Rails)

module Florrick
  
  # A quick helper method for quickly running conversion
  def self.convert(string, objects = {})
    Builder.new(string, objects).output
  end
  
end
