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
    it 'creates the :up json as expected' do
      move = Move.new(:up)

      parsed_json = JSON.parse(json = move.to_json, {symbolize_names: true})

      expect(parsed_json).to include(direction: "u")
    end

    it 'creates the :down json as expected' do
      move = Move.new(:down)

      parsed_json = JSON.parse(json = move.to_json, {symbolize_names: true})

      expect(parsed_json).to include(direction: "d")
    end

    it 'creates the :left json as expected' do
      move = Move.new(:left)

      parsed_json = JSON.parse(json = move.to_json, {symbolize_names: true})

      expect(parsed_json).to include(direction: "l")
    end

    it 'creates the :right json as expected' do
      move = Move.new(:right)

      parsed_json = JSON.parse(json = move.to_json, {symbolize_names: true})

      expect(parsed_json).to include(direction: "r")
    end
  end
end
