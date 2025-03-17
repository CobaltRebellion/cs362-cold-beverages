require_relative '../lib/chiller'

describe 'A chiller' do

    it "has capacity, temperature, power, and contents" do
        chiller = Chiller.new

        expect(chiller.capacity).to eq(100)
        expect(chiller.temperature).to eq(70)
        expect(chiller.instance_variable_get(:@power)).to eq(:off)
        expect(chiller.instance_variable_get(:@contents)).to eq([])
    end

    it "can turn on" do
        chiller = Chiller.new
        chiller.turn_on
        expect(chiller.instance_variable_get(:@power)).to eq(:on)
    end

    it "can turn off" do
        chiller = Chiller.new
        chiller.turn_on
        chiller.turn_off
        expect(chiller.instance_variable_get(:@power)).to eq(:off)
    end

    it "can add items and check capacity" do
        chiller = Chiller.new(100)
        item = Item.new("Beej", 10)
        
        expect(chiller.remaining_capacity).to eq(100)

        chiller.add(item)
        expect(chiller.remaining_capacity).to eq(90)
    end

    it "can set temperature" do
        chiller = Chiller.new

        expect(chiller.temperature).to eq(70)

        chiller.set_level(4)
        expect(chiller.temperature).to eq(50)
    end
end
