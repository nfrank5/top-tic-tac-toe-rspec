# frozen_string_literal: true
require_relative './board'

class Game
  attr_reader :current_board

  def initialize(board = Board.new)
    @current_board = board
    @player_one = ''
    @player_two = ''
    @current_player = { name: @player_one, mark: 'X' }
  end

  def play
    introduction
    @player_one = get_players('Insert name of player one')
    @player_two = get_players('Insert name of player two')
    @current_player = { name: @player_one, mark: 'X' }
    placing_marks
    ending
  end

  def introduction
    puts <<~HEREDOC
      Welcome to Tic Tac Toe!
      Please enter a different name for each player (between 3 and 10 characters).
      Have fun!
    HEREDOC
  end

  def get_players(insert_name)
    puts insert_name
    player_name_input
  end

  def player_name_input
    loop do
      user_input = gets.chomp
      verified_name = user_input if user_input.match?(/^.{3,10}$/) && @player_one != user_input
      return verified_name if verified_name

      puts 'Please enter a different name for each player (between 3 and 10 characters).'
    end
  end

  def clear_screen
    system('cls') || system('clear')
  end

  def placing_marks
    clear_screen 
    current_board.print_board  
    9.times do
      puts "#{@player_one}: is X and #{@player_two} is: O"
      mark_if_space_free
      break if current_board.check_for_winner
      
      clear_screen
      current_board.print_board 
      @current_player = switch_turn
    end
  end

  def player_mark_input
    puts "It's #{@current_player[:name]} turn"
    loop do
      move = gets.chomp.downcase
      verified_mark = move if move.match?(/^[abc][123]$/) 
      return verified_mark if verified_mark

      puts 'Please enter a single letter and a single digit without spaces.'
    end
  end

  def mark_if_space_free
    loop do
      verified_mark = player_mark_input.split('')
      unless current_board.update_space(verified_mark[1].to_i - 1, verified_mark[0].to_sym, @current_player[:mark])
        clear_screen 
        current_board.print_board
        puts 'Mark a free space'
        next
      end
      break
    end
  end

  def switch_turn
    if @current_player[:name] == @player_one
      { name: @player_two, mark:'O' }
    else
      { name: @player_one, mark:'X' }
    end
  end

  def ending
    current_board.print_board(true)
    if current_board.check_for_winner
      puts "#{@current_player[:name]} is the winner!!!"
    else
      clear_screen
      current_board.print_board(true)
      puts "It's a draw"
    end
  end


end

