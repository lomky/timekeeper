require 'nava_timekeeper'

RSpec.describe NavaTimekeeper, "#calculate" do
  context "with defaults" do
    it "gives the right numbers" do
      navaTimekeeper = NavaTimekeeper.new

      navaTimekeeper.calculate

      expect(navaTimekeeper.billable_minimum.round(2)).to eq(82.28)
      expect(navaTimekeeper.nonbillable_budget.round(2)).to eq(5.72)
    end
  end

  context "with set minimum_hours" do
    it "gives the right numbers" do
      navaTimekeeper = NavaTimekeeper.new

      navaTimekeeper.minimum_hours = 80

      navaTimekeeper.calculate

      expect(navaTimekeeper.billable_minimum.round(2)).to eq(74.8)
      expect(navaTimekeeper.nonbillable_budget.round(2)).to eq(5.2)
    end
  end

  context "with set leave" do
    it "gives the right numbers" do
      navaTimekeeper = NavaTimekeeper.new

      navaTimekeeper.leave = 8

      navaTimekeeper.calculate

      expect(navaTimekeeper.billable_minimum.round(2)).to eq(74.8)
      expect(navaTimekeeper.nonbillable_budget.round(2)).to eq(5.2)
    end
  end

  context "with set minimum_hours and leave" do
    it "gives the right numbers" do
      navaTimekeeper = NavaTimekeeper.new

      navaTimekeeper.minimum_hours = 80
      navaTimekeeper.leave = 17.25

      navaTimekeeper.calculate

      expect(navaTimekeeper.billable_minimum.round(2)).to eq(58.67)
      expect(navaTimekeeper.nonbillable_budget.round(2)).to eq(4.08)
    end
  end
end
