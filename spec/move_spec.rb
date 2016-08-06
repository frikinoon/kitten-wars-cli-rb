require 'spec_helper'
require 'move'

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
  end
end
