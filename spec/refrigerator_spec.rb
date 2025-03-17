require_relative '../lib/refrigerator'

describe 'A refrigerator' do
    # these begining ones are probably a bit overboard but might as well, theres nothing wrong with more tests
    it "has a chiller, freezer, water dispenser, water reservoir, and power" do
        chiller = Chiller.new
        freezer = Freezer.new
        reservoir = WaterReservoir.new(10, 10)
        dispenser = WaterDispenser.new(reservoir)
        
        fridge = Refrigerator.new(chiller, freezer, dispenser, reservoir)

        expect(fridge.chiller).to eq(chiller)
        expect(fridge.freezer).to eq(freezer)
        expect(fridge.water_dispenser).to eq(dispenser)
        expect(fridge.water_reservoir).to eq(reservoir)
        expect(fridge.instance_variable_get(:@power)).to eq(:off)
    end

    it "can chill an item" do
        # init everything the fridge needs, and then the fridge itself
        chiller = Chiller.new
        freezer = Freezer.new
        reservoir = WaterReservoir.new(10, 10)
        dispenser = WaterDispenser.new(reservoir)

        fridge = Refrigerator.new(chiller, freezer, dispenser, reservoir)

        item = Item.new("Beej", 10)

        expect(chiller.remaining_capacity).to eq(100)

        fridge.chill(item)

        expect(chiller.remaining_capacity).to eq(90)
    end

    it "can freeze an item" do
        # init everything the fridge needs, and then the fridge itself
        chiller = Chiller.new
        freezer = Freezer.new
        reservoir = WaterReservoir.new(10, 10)
        dispenser = WaterDispenser.new(reservoir)

        fridge = Refrigerator.new(chiller, freezer, dispenser, reservoir)

        item = Item.new("Beej", 10)

        expect(freezer.remaining_capacity).to eq(100)

        fridge.freeze(item)

        expect(freezer.remaining_capacity).to eq(90)
    end

    it "can check total capacity" do
        # init everything the fridge needs, and then the fridge itself
        chiller = Chiller.new(100)
        freezer = Freezer.new(100)
        reservoir = WaterReservoir.new(10, 10)
        dispenser = WaterDispenser.new(reservoir)

        fridge = Refrigerator.new(chiller, freezer, dispenser, reservoir)

        expect(fridge.total_capacity).to eq(200)
    end

    it "can check remaining capacity" do
        # init everything the fridge needs, and then the fridge itself
        chiller = Chiller.new(100)
        freezer = Freezer.new(100)
        reservoir = WaterReservoir.new(10, 10)
        dispenser = WaterDispenser.new(reservoir)

        fridge = Refrigerator.new(chiller, freezer, dispenser, reservoir)

        item = Item.new("Beej", 10)

        expect(fridge.total_capacity).to eq(200)

        fridge.freeze(item)

        expect(fridge.remaining_capacity).to eq(190)
    end

    it "can be plugged in" do
        # init everything the fridge needs, and then the fridge itself
        chiller = Chiller.new
        freezer = Freezer.new
        reservoir = WaterReservoir.new(10, 10)
        dispenser = WaterDispenser.new(reservoir)

        fridge = Refrigerator.new(chiller, freezer, dispenser, reservoir)

        fridge.plug_in

        expect(fridge.instance_variable_get(:@power)).to eq(:on)
        expect(fridge.chiller.instance_variable_get(:@power)).to eq(:on)
        expect(fridge.freezer.instance_variable_get(:@power)).to eq(:on)
    end

    it "can be unplugged" do
        # init everything the fridge needs, and then the fridge itself
        chiller = Chiller.new
        freezer = Freezer.new
        reservoir = WaterReservoir.new(10, 10)
        dispenser = WaterDispenser.new(reservoir)

        fridge = Refrigerator.new(chiller, freezer, dispenser, reservoir)

        fridge.plug_in
        fridge.unplug

        expect(fridge.instance_variable_get(:@power)).to eq(:off)
        expect(fridge.chiller.instance_variable_get(:@power)).to eq(:off)
        expect(fridge.freezer.instance_variable_get(:@power)).to eq(:off)
    end

    it "can set chiller temperture level" do
        # init everything the fridge needs, and then the fridge itself
        chiller = Chiller.new
        freezer = Freezer.new
        reservoir = WaterReservoir.new(10, 10)
        dispenser = WaterDispenser.new(reservoir)

        fridge = Refrigerator.new(chiller, freezer, dispenser, reservoir)

        fridge.set_chiller_level(4)

        expect(fridge.chiller.temperature).to eq(50)
    end

    it "can set freezer temperture level" do
        # init everything the fridge needs, and then the fridge itself
        chiller = Chiller.new
        freezer = Freezer.new
        reservoir = WaterReservoir.new(10, 10)
        dispenser = WaterDispenser.new(reservoir)

        fridge = Refrigerator.new(chiller, freezer, dispenser, reservoir)

        fridge.set_freezer_level(4)

        expect(fridge.freezer.temperature).to eq(30)
    end

    it "display its variables as a string" do
         # init everything the fridge needs, and then the fridge itself
         chiller = Chiller.new
         freezer = Freezer.new
         reservoir = WaterReservoir.new(10, 10)
         dispenser = WaterDispenser.new(reservoir)
 
         fridge = Refrigerator.new(chiller, freezer, dispenser, reservoir)

         expect(fridge.to_s).to eq(
            <<~STATUS
            Power: #{fridge.instance_variable_get(:@power)}
            Storage: #{fridge.remaining_capacity} of #{fridge.total_capacity} available
            Temps: Chiller is #{fridge.chiller.temperature}, Freezer is #{fridge.freezer.temperature}
            Water: Reservoir has #{fridge.water_reservoir.current_water_volume} remaining.
            STATUS
         )

    end
end
