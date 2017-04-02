ENV['RACK_ENV'] = 'test'
require 'rack/test'
require 'minitest/autorun'
require 'mocha/mini_test'

require_relative '../giftexter.rb'
