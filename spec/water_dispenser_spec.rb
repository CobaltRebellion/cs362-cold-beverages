require_relative '../lib/water_dispenser'

describe 'A water dispenser' do
    it "has a reservoir" do
        reservoir = WaterReservoir.new(10, 10)
        dispenser = WaterDispenser.new(reservoir)

        expect(dispenser.reservoir.capacity).to eq(10)
        expect(dispenser.reservoir.current_water_volume).to eq(10)
    end

    it "can dispense" do
        reservoir = WaterReservoir.new(10, 10)
        dispenser = WaterDispenser.new(reservoir)

        vessel = Vessel.new("FAKE", 9)

        dispenser.dispense(vessel)
        expect(dispenser.reservoir.current_water_volume).to eq(1)
    end

    it "can't dispense beyond reservoir amount" do
        reservoir = WaterReservoir.new(10, 10)
        dispenser = WaterDispenser.new(reservoir)

        vessel = Vessel.new("FAKE", 11)

        dispenser.dispense(vessel)
        expect(dispenser.reservoir.current_water_volume).to eq(0)
    end

    it "fill vessel when dispensing water" do
        reservoir = WaterReservoir.new(10, 10)
        dispenser = WaterDispenser.new(reservoir)

        vessel = Vessel.new("FAKE", 11)

        dispenser.dispense(vessel)
        expect(vessel.contents).to eq(vessel.volume)
    end
end
