class Board 
  attr_reader :board

  def initialize
    @board = [{ a: ' ', b: ' ', c: ' ' },
              { a: ' ', b: ' ', c: ' ' },
              { a: ' ', b: ' ', c: ' ' }
             ]
  end

  def update_row(row, column, value)
    if board[row][column] == ' '
      board[row][column] = value
      return true
    end
    false
  end

  def check_for_winner
    check_rows || check_columns || check_diagonals
  end

  def check_rows
    winner = false
    board.each do |row|
      winner = true if  row[:a] == row[:b] &&
                        row[:b] == row[:c] &&
                        row[:c] != ' '
    end
    winner
  end

  def check_columns
    winner = false
    %i[a b c].each do |column|
      winner = true if  board[0][column] == board[1][column] &&
                        board[1][column] == board[2][column] &&
                        board[0][column] != ' '
    end
    winner
  end

  def check_diagonals
    winner = false
    winner = true if  board[0][:a] == board[1][:b] &&
                      board[1][:b] == board[2][:c] &&
                      board[0][:a] != ' '

    winner = true if  board[0][:c] == board[1][:b] &&
                      board[1][:b] == board[2][:a] &&
                      board[0][:c] != ' '
    winner
  end

  def print_board(ending = false)
    puts 'Place a mark in a free space(for example: A1)' unless ending

    puts <<~HEREDOC
          A   B   C
      1   #{@board[0][:a]} | #{@board[0][:b]} | #{@board[0][:c]}
        ------------
      2   #{@board[1][:a]} | #{@board[1][:b]} | #{@board[1][:c]}
        ------------
      3   #{@board[2][:a]} | #{@board[2][:b]} | #{@board[2][:c]}

      HEREDOC
      
  end
end









