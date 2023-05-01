require 'rubygems'
require 'bundler/setup'
require 'puma'

Bundler.require

require './app'

run App.run!
