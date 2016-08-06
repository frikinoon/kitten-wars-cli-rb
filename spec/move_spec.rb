require 'spec_helper'
require 'move'
require 'json'
require 'pp'

describe Move do
  describe "#new" do
    it 'creates a new up move' do
      move = Move.new(:up)
      expect(move.direction).to be :up
    end

    it 'creates a new down move' do
      move = Move.new(:down)
      expect(move.direction).to be :down
    end

    it 'creates a new left move' do
      move = Move.new(:left)
      expect(move.direction).to be :left
    end

    it 'creates a new right move' do
      move = Move.new(:right)
      expect(move.direction).to be :right
    end

    it 'throws an exception if given a wrong direction' do
      expect{ Move.new(:other) }.to raise_error(ArgumentError)
    end
  end

  describe "#to_json" do
    {
      up: "u",
      down: "d",
      left: "l",
      right: "r",
    }.each_pair do |symbol, direction|
      it 'creates the #{symbol} json as expected' do
        move = Move.new(symbol)

        parsed_json = JSON.parse(json = move.to_json, {symbolize_names: true})

        expect(parsed_json).to include(direction: direction)
      end
    end
  end
end
