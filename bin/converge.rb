#!/usr/bin/env ruby
require 'rubygems'
require File.expand_path('../lib/converge',File.dirname(__FILE__))
DTK::Converge::PuppetApply.run()
