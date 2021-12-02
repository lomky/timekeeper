require 'timekeeper'

RSpec.describe Timekeeper, "#calculate" do
  context "with defaults" do
    it "gives the right numbers" do
      timekeeper = Timekeeper.new

      timekeeper.calculate

      expect(timekeeper.billable_minimum.round(2)).to eq(82.28)
      expect(timekeeper.nonbillable_budget.round(2)).to eq(5.72)
    end
  end

  context "with set minimum_hours" do
    it "gives the right numbers" do
      timekeeper = Timekeeper.new

      timekeeper.minimum_hours = 80

      timekeeper.calculate

      expect(timekeeper.billable_minimum.round(2)).to eq(74.8)
      expect(timekeeper.nonbillable_budget.round(2)).to eq(5.2)
    end
  end

  context "with set leave" do
    it "gives the right numbers" do
      timekeeper = Timekeeper.new

      timekeeper.leave = 8

      timekeeper.calculate

      expect(timekeeper.billable_minimum.round(2)).to eq(74.8)
      expect(timekeeper.nonbillable_budget.round(2)).to eq(5.2)
    end
  end

  context "with set minimum_hours and leave" do
    it "gives the right numbers" do
      timekeeper = Timekeeper.new

      timekeeper.minimum_hours = 80
      timekeeper.leave = 17.25

      timekeeper.calculate

      expect(timekeeper.billable_minimum.round(2)).to eq(58.67)
      expect(timekeeper.nonbillable_budget.round(2)).to eq(4.08)
    end
  end
end
