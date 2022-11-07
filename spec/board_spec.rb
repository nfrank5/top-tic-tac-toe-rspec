# frozen_string_literal: true
require_relative '../lib/board'

describe Board do
  describe '#check_winner_rows' do
    context 'when the first row has three O' do
      subject(:board_check_rows) { described_class.new(board = [  { a: 'O', b: 'O', c: 'O' },
                                                                  { a: ' ', b: ' ', c: ' ' },
                                                                  { a: ' ', b: ' ', c: ' ' }]) }
      it 'returns true' do
        expect(board_check_rows.check_winner_rows).to be true
      end
    end

    context 'when the second row has three X' do
      subject(:board_check_rows) { described_class.new(board = [  { a: ' ', b: ' ', c: ' ' },
                                                                  { a: 'X', b: 'X', c: 'X' },
                                                                  { a: ' ', b: ' ', c: ' ' }]) }
      it 'returns true' do
        expect(board_check_rows.check_winner_rows).to be true
      end
    end

    context 'when the third row has three X' do
      subject(:board_check_rows) { described_class.new(board = [  { a: ' ', b: ' ', c: ' ' },
                                                                  { a: ' ', b: ' ', c: ' ' },
                                                                  { a: 'X', b: 'X', c: 'X' }]) }
      it 'returns true' do
        expect(board_check_rows.check_winner_rows).to be true
      end
    end

    context 'when the third row has two X and one O' do
      subject(:board_check_rows) { described_class.new(board = [  { a: ' ', b: ' ', c: ' ' },
                                                                  { a: ' ', b: ' ', c: ' ' },
                                                                  { a: 'X', b: 'X', c: 'O' }]) }
      it 'returns false' do
        expect(board_check_rows.check_winner_rows).to be false
      end
    end

    context 'when the board is empty' do
      subject(:board_check_rows) { described_class.new }
      it 'returns false' do
        expect(board_check_rows.check_winner_rows).to be false
      end
    end
  end

  describe '#check_winner_columns' do
    context 'when the first column has three X' do
      subject(:board_check_columns) { described_class.new(board = [ { a: 'X', b: ' ', c: ' ' },
                                                                    { a: 'X', b: ' ', c: ' ' },
                                                                    { a: 'X', b: ' ', c: ' ' }]) }
      it 'returns true' do
        expect(board_check_columns.check_winner_columns).to be true
      end
    end

    context 'when the second column has three O' do
      subject(:board_check_columns) { described_class.new(board = [ { a: ' ', b: 'O', c: ' ' },
                                                                    { a: ' ', b: 'O', c: ' ' },
                                                                    { a: ' ', b: 'O', c: ' ' }]) }
      it 'returns true' do
        expect(board_check_columns.check_winner_columns).to be true
      end
    end

    context 'when the third column has three X' do
      subject(:board_check_columns) { described_class.new(board = [ { a: ' ', b: ' ', c: 'X' },
                                                                    { a: ' ', b: ' ', c: 'X' },
                                                                    { a: ' ', b: ' ', c: 'X' }]) }
      it 'returns true' do
        expect(board_check_columns.check_winner_columns).to be true
      end
    end

    context 'when the second column has two X and one O' do
      subject(:board_check_columns) { described_class.new(board = [ { a: ' ', b: 'X', c: ' ' },
                                                                    { a: ' ', b: 'X', c: ' ' },
                                                                    { a: ' ', b: 'O', c: ' ' }]) }
      it 'returns false' do
        expect(board_check_columns.check_winner_columns).to be false
      end
    end

    context 'when the board is empty' do
      subject(:board_check_rows) { described_class.new }
      it 'returns false' do
        expect(board_check_rows.check_winner_columns).to be false
      end
    end
  end
  
  describe '#check_winner_diagonals' do
    context 'when the first diagonal has three X' do
      subject(:board_check_diagonals) { described_class.new(board = [  { a: 'X', b: ' ', c: ' ' },
                                                                       { a: ' ', b: 'X', c: ' ' },
                                                                       { a: ' ', b: ' ', c: 'X' }]) }
      it 'returns true' do
        expect(board_check_diagonals.check_winner_diagonals).to be true
      end
    end

    context 'when the second diagonal has three O' do
      subject(:board_check_diagonals) { described_class.new(board = [  { a: ' ', b: ' ', c: 'O' },
                                                                       { a: ' ', b: 'O', c: ' ' },
                                                                       { a: 'O', b: ' ', c: ' ' }]) }
      it 'returns true' do
        expect(board_check_diagonals.check_winner_diagonals).to be true
      end
    end

    context 'when the second diagonal has two O and one X' do
      subject(:board_check_diagonals) { described_class.new(board = [  { a: ' ', b: ' ', c: 'O' },
                                                                       { a: ' ', b: 'X', c: ' ' },
                                                                       { a: 'O', b: ' ', c: ' ' }]) }
      it 'returns false' do
        expect(board_check_diagonals.check_winner_diagonals).to be false
      end
    end   

    context 'when the board is empty' do
      subject(:board_check_rows) { described_class.new }
      it 'returns false' do
        expect(board_check_rows.check_winner_diagonals).to be false
      end
    end
  end

  describe '#update_space' do
    context 'when the the A1 space is empty and you add a circle' do
      subject(:board_update_space) { described_class.new }
      it 'adds a circle to the A1 space' do
        board_update_space.update_space(0, :a, 'O')
        expect(board_update_space.board[0][:a]).to eq('O')
      end
    end

    context 'when the the C3 space is empty and you add a circle' do
      subject(:board_update_space) { described_class.new }
      it 'adds a circle to the C3 space' do
        board_update_space.update_space(2, :c, 'O')
        expect(board_update_space.board[2][:c]).to eq('O')
      end
    end 

    context 'when the the row is out of the board' do
      subject(:board_update_space) { described_class.new }
      it 'returns false' do
        expect(board_update_space.update_space(3, :a, 'O')).to be false
      end
    end

    context 'when the the column is out of the board' do
      subject(:board_update_space) { described_class.new }
      it 'returns false' do
        expect(board_update_space.update_space(2, :d, 'O')).to be false
      end
    end

  end

end