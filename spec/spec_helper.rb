require 'minitest/spec'
require 'minitest/autorun'

require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new

Dir[File.join(File.dirname(__FILE__), '..', 'lib', '*.rb')].each{|f| require f }
