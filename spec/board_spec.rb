require 'spec_helper'
require 'board'

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
end
