require 'optparse'

BILLABLE_RATIO = 0.935

class NavaTimekeeper
  attr_accessor :minimum_hours, :leave, :billable_minimum, :nonbillable_budget, :hour_minutes

  def initialize
    self.hour_minutes = false
    self.minimum_hours = 88
    self.leave = 0
  end

  def calculate
    effective_time = (self.minimum_hours - self.leave)
    self.billable_minimum = effective_time * BILLABLE_RATIO
    self.nonbillable_budget = effective_time - self.billable_minimum
  end

  def print
    if self.hour_minutes
      print_time
    else
      print_decimal
    end
  end

  def print_decimal
    puts "For a time period of #{self.minimum_hours} with #{self.leave} hours leave:"
    puts "Billable hours goal: #{self.billable_minimum.round(2)}"
    puts " Nonbillable budget: #{self.nonbillable_budget.round(2)}"
  end

  def print_time
    puts "For a time period of #{self.minimum_hours} with #{to_hour_minute(self.leave)} leave:"
    puts "Billable hours goal: #{to_hour_minute(self.billable_minimum)}"
    puts " Nonbillable budget: #{to_hour_minute(self.nonbillable_budget)}"
  end

  def to_hour_minute(time)
    hours = ((time * 60) / 60).floor(0)
    minutes = (time * 60) % 60

    if hours == 0 && minutes == 0
      "0h"
    elsif hours == 0
      "#{minutes.round(0)}m"
    else
      "#{hours}h:#{minutes.round(0)}m"
    end
  end

  def parse
    OptionParser.new do |parser|
      parser.banner = 'Usage: nava-timekeeper [options]'
      parser.separator ''
      parser.separator 'Calculates your Nava Timekeeping Math for you. Assumes a goal of 93.5% billable, and that you do not wish to work more than the minimum hours for this time period (aka 40/wk).'
      parser.separator ''
      parser.separator 'Note this program outputs exact minutes, i.e. 4h:23m (4.39h), while in reality we use 15m (0.25h) blocks at the smallest.'
      parser.separator ''

      parser.on('-m', '--minimum MIN', Integer, 'Mimimum hours requires for the timesheet. Default 88.') do |minimum|
        self.minimum_hours = minimum
      end

      parser.on('-l', '--leave LEAVE', Float, 'Hours of leave. Default 0.') do |leave|
        self.leave = leave
      end

      parser.on('-c', '--clock', 'Display output in HH:MM time instead of the default, decimal') do |hour_minutes|
        self.hour_minutes = hour_minutes
      end

      parser.on('-h', '--help', 'Show this message') do
        puts parser
        exit
      end
    end.parse!
  end
end
