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

  context "for a manager" do
    it "gives the right numbers" do
      timekeeper = Timekeeper.new

      timekeeper.manager = 'regular'

      timekeeper.calculate

      expect(timekeeper.billable_minimum.round(2)).to eq(77)
      expect(timekeeper.nonbillable_budget.round(2)).to eq(11)
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

  context "with set minimum_hours and leave as a manager" do
    it "gives the right numbers" do
      timekeeper = Timekeeper.new

      timekeeper.minimum_hours = 40
      timekeeper.leave = 8
      timekeeper.manager = 'overloaded'

      timekeeper.calculate

      expect(timekeeper.billable_minimum.round(2)).to eq(27.2)
      expect(timekeeper.nonbillable_budget.round(2)).to eq(4.8)
    end
  end


end

RSpec.describe Timekeeper, "#print" do
  context "format decimal" do
    expected_result = "For a time period of 88 hours with 0 hours leave:\n    Billable hours goal: 82.28\n     Nonbillable budget: 5.72"

    context "no format given" do
      it "gives the decimal format" do
        timekeeper = Timekeeper.new
        timekeeper.calculate

        expect(timekeeper.print).to eq(expected_result)
      end
    end

    context "when specified" do
      it "gives the decimal format" do
        timekeeper = Timekeeper.new
        timekeeper.format = 'decimal'
        timekeeper.calculate

        expect(timekeeper.print).to eq(expected_result)
      end
    end

    context "as a fallback" do
      it "gives the decimal format" do
        timekeeper = Timekeeper.new
        timekeeper.format = 'foo'
        timekeeper.calculate

        expect(timekeeper.print).to eq(expected_result)
      end
    end
  end

  context "format clock" do
    it "gives the proper clock format" do
      timekeeper = Timekeeper.new
      timekeeper.format = 'clock'
      timekeeper.calculate

      expected_result = "For a time period of 88h with 0h leave:\n    Billable hours goal: 82h:17m\n     Nonbillable budget: 5h:43m"

      expect(timekeeper.print).to eq(expected_result)
    end
  end

  context "format csv" do
    it "gives the proper csv format" do
      timekeeper = Timekeeper.new
      timekeeper.format = 'csv'
      timekeeper.calculate

      expected_result = "minimum_hours,leave,billable_minimum,nonbillable_budget\n88,0,82.28,5.719999999999999"

      expect(timekeeper.print).to eq(expected_result)
    end
  end
end
