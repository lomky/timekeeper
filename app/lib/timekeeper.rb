require 'optparse'

BILLABLE_RATIO = 0.935
BILLABLE_RATIO_MANAGER = 0.875
BILLABLE_RATIO_OVERLOADED_MANAGER = 0.85

class Timekeeper
  attr_accessor :minimum_hours, :leave, :billable_minimum, :nonbillable_budget, :format, :manager, :reverse

  def initialize
    self.format = 'decimal'
    self.minimum_hours = 88
    self.leave = 0
  end

  def calculate
    effective_time = (self.minimum_hours.to_f - self.leave)
    if self.reverse
      self.billable_minimum = self.reverse / effective_time * 100
      self.nonbillable_budget = (effective_time - self.reverse) / effective_time * 100
    else
      self.billable_minimum = effective_time * billable_ratio
      self.nonbillable_budget = effective_time - self.billable_minimum
    end
  end

  def billable_ratio
    if self.manager == 'regular'
      BILLABLE_RATIO_MANAGER
    elsif self.manager == 'overloaded'
      BILLABLE_RATIO_OVERLOADED_MANAGER
    else
      BILLABLE_RATIO
    end

  end

  def print
    if self.reverse
      format_percent
    elsif self.format == 'clock'
      format_clock
    elsif self.format == 'csv'
      format_csv
    else
      format_decimal
    end
  end

  def format_csv
    "minimum_hours,leave,billable_minimum,nonbillable_budget\n#{self.minimum_hours},#{self.leave},#{self.billable_minimum},#{self.nonbillable_budget}"
  end

  def format_decimal
    "For a time period of #{self.minimum_hours} hours with #{self.leave} hours leave:\n\
    Billable hours goal: #{self.billable_minimum.round(2)}\n\
     Nonbillable budget: #{self.nonbillable_budget.round(2)}"
  end

  def format_clock
    "For a time period of #{self.minimum_hours}h with #{to_hour_minute(self.leave)} leave:\n\
    Billable hours goal: #{to_hour_minute(self.billable_minimum)}\n\
     Nonbillable budget: #{to_hour_minute(self.nonbillable_budget)}"
  end

  def format_percent
    "For a time period of #{self.minimum_hours} hours with #{self.leave} hours leave, with #{self.reverse} billable hours:\n\
    Billable hours percentage: #{self.billable_minimum.round(2)}%\n\
       Nonbillable percentage: #{self.nonbillable_budget.round(2)}%"
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
      parser.banner = 'Usage: timekeeper [options]'
      parser.separator ''
      parser.separator 'Calculates your Timekeeper Math for you. Assumes a goal of 93.5% billable, and that you do not wish to work more than the minimum hours for this time period (aka 40/wk).'
      parser.separator ''
      parser.separator 'Note this program outputs exact minutes, i.e. 4h:23m (4.39h), while in reality we use 15m (0.25h) blocks at the smallest. Clock & Decimal outputs round to two places, CSV is exact.'
      parser.separator ''

      parser.on('-m', '--minimum MIN', Integer, 'Mimimum hours requires for the timesheet. Default 88.') do |minimum|
        self.minimum_hours = minimum
      end

      parser.on('-l', '--leave LEAVE', Float, 'Hours of leave. Default 0.') do |leave|
        self.leave = leave
      end

      parser.on('-f', '--format FORMAT', 'Display output clock, csv, or decimal (default)') do |format|
        self.format = format
      end

      parser.on('-n', '--manager MANAGER', String, 'regular, overloaded, or IC (default)') do |manager|
        self.manager = manager
      end

      parser.on('-r', '--reverse HOURS', Float, 'Inverts the calculation and tells you your percentages') do |reverse|
        self.reverse = reverse
      end

      parser.on('-h', '--help', 'Show this message') do
        puts parser
        exit
      end
    end.parse!
  end
end
