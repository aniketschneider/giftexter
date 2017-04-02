#$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
ENV['RACK_ENV'] = 'test'
require 'rack/test'

require_relative '../giftexter.rb'
