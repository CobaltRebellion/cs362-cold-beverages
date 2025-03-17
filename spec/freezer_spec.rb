require_relative '../lib/freezer'

describe 'A freezer' do

    it "has capacity, temperature, power, and contents" do
        freezer = Freezer.new

        expect(freezer.capacity).to eq(100)
        expect(freezer.temperature).to eq(70)
        expect(freezer.instance_variable_get(:@power)).to eq(:off)
        expect(freezer.instance_variable_get(:@contents)).to eq([])
    end

    it "can turn on" do
        freezer = Freezer.new
        freezer.turn_on
        expect(freezer.instance_variable_get(:@power)).to eq(:on)
    end

    it "can turn off" do
        freezer = Freezer.new
        freezer.turn_on
        freezer.turn_off
        expect(freezer.instance_variable_get(:@power)).to eq(:off)
    end

    it "can add items and check capacity" do
        freezer = Freezer.new(100)
        item = Item.new("Beej", 10)
        
        expect(freezer.remaining_capacity).to eq(100)

        freezer.add(item)
        expect(freezer.remaining_capacity).to eq(90)
    end

    it "can set temperature" do
        freezer = Freezer.new

        expect(freezer.temperature).to eq(70)

        freezer.set_level(4)
        expect(freezer.temperature).to eq(30)
    end

end
