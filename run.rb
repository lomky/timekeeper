#!/usr/bin/env ruby

require_relative 'lib/nava_timekeeper'

navaTimekeeper = NavaTimekeeper.new
navaTimekeeper.parse
navaTimekeeper.calculate
navaTimekeeper.print
