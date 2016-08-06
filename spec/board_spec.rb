require 'spec_helper'
require 'board'
require 'json'

describe Board do
  describe "#new" do
    it 'creates a 16x16 board' do
      board = Board.new(16,16)

      expect(board.width).to eq 16
      expect(board.height).to eq 16
    end

    it 'creates a board with a different size' do
      board = Board.new(32,32)

      expect(board.width).to eq 32
      expect(board.height).to eq 32
    end
  end

  describe "#to_json" do
    it 'creates the expected :json' do
      board = Board.new(32,32)

      parsed_json = JSON.parse(board.to_json, {symbolize_names: true})

      expect(parsed_json).to include(width: 32)
      expect(parsed_json).to include(height: 32)
    end
  end
end
