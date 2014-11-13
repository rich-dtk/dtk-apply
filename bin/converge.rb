#!/usr/bin/env ruby
require 'rubygems'
require 'optparse'
require File.expand_path('../lib/converge',File.dirname(__FILE__))
options = Hash.new
OptionParser.new do|opts|
   opts.banner = "Usage: converge.rb [--mock] [--logging LOGGING-MODE]"

  # Define the options, and what they do
  opts.on( '-m', '--mock', "Mock mode") do 
    options[:mock_mode] = true
  end

  opts.on( '-l', '--logging LOGGING-MODE', "Logging Mode") do |logging_mode|
    legal_vals = ['off','false','on','true']
    if ['off','false'].include?(logging_mode)
      options[:logging] = 'off'
    elsif ['on','true'].include?(logging_mode)
      options[:logging] = 'on'
    else
      legal_vals_pp = "[#{legal_vals.join(',')}]"
      raise DTK::Error.new("Illegal logging mode (#{logging_mode}); legal values are: #{legal_vals_pp}")
    end
  end
end.parse!
DTK::Converge.create(:puppet_apply,options).run()

