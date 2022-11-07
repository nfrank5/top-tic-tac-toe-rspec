# frozen_string_literal: true
require_relative '../lib/game'
require_relative '../lib/board'

describe Game do
  describe '#player_name_input' do
    subject(:game_players_name) { described_class.new }
    context 'when the input is valid' do
      before do
        valid_input = 'Name1'
        allow(game_players_name).to receive(:gets).and_return(valid_input)
      end
      it 'stops loop and does not display error message' do
        error_message = 'Please enter a different name for each player (between 3 and 10 characters).'
        expect(game_players_name).not_to receive(:puts).with(error_message)
        game_players_name.player_name_input
      end
    end

    context 'when the input is invalid once' do
      before do
        invalid_input = 'Namethatistoolong1234567890'
        valid_input = 'Name1'
        allow(game_players_name).to receive(:gets).and_return(invalid_input, valid_input)
      end
      it 'display error message once then stops loop and does not display error message' do
        error_message = 'Please enter a different name for each player (between 3 and 10 characters).'
        expect(game_players_name).to receive(:puts).with(error_message).once
        game_players_name.player_name_input
      end
    end

    context 'when the input is invalid twice' do
      before do
        invalid_input1 = 'Name1234567890'
        invalid_input2 = ''
        valid_input = 'Name1'
        allow(game_players_name).to receive(:gets).and_return(invalid_input1, invalid_input2, valid_input)
      end
      it 'display error message twice then stops loop and does not display error message' do
        error_message = 'Please enter a different name for each player (between 3 and 10 characters).'
        expect(game_players_name).to receive(:puts).with(error_message).twice
        game_players_name.player_name_input
      end
    end
  end

  describe '#placing_marks' do
    subject(:game_placing_marks) { described_class.new(board_placing_marks) }
    let(:board_placing_marks) { instance_double(Board) }
    context 'when there is no winner' do
      before do
        allow(board_placing_marks).to receive(:print_board)
        allow(board_placing_marks).to receive(:check_for_winner)
        allow(game_placing_marks).to receive(:clear_screen)
        allow(game_placing_marks).to receive(:puts)
      end

      it 'breaks the loop after 9 times' do
        expect(game_placing_marks).to receive(:mark_if_space_free).exactly(9).times
        game_placing_marks.placing_marks
      end
    end

    context 'when there is a winner' do

      before do
        allow(board_placing_marks).to receive(:print_board)
        allow(board_placing_marks).to receive(:check_for_winner).and_return(true)
        allow(game_placing_marks).to receive(:clear_screen)
        allow(game_placing_marks).to receive(:puts)
      end

      it 'breaks the loop if check_for_winner returns true' do
        expect(game_placing_marks).to receive(:mark_if_space_free).once
        game_placing_marks.placing_marks
      end

    end
  end

  describe '#mark_if_space_free' do
    subject(:game_mark_if_space_free) { described_class.new(board_mark_if_space_free) }
    let(:board_mark_if_space_free) { instance_double(Board) }

    context 'when the space is free' do
      before do
        allow(game_mark_if_space_free).to receive(:player_mark_input).and_return('a1')
        allow(board_mark_if_space_free).to receive(:update_space).and_return(true)
        allow(game_mark_if_space_free).to receive(:clear_screen)

      end
      it 'breaks the loop' do
        expect(board_mark_if_space_free).not_to receive(:print_board)
        expect(board_mark_if_space_free).to receive(:update_space).once
        game_mark_if_space_free.mark_if_space_free
      end
    end

    context 'when the space is not free once and then is empty' do
      before do
        allow(game_mark_if_space_free).to receive(:player_mark_input).and_return('a1')
        allow(board_mark_if_space_free).to receive(:update_space).and_return(false, true)
        allow(game_mark_if_space_free).to receive(:clear_screen)
        allow(game_mark_if_space_free).to receive(:puts)


      end
      it 'doesn\'t break the loop the first time' do
        expect(board_mark_if_space_free).to receive(:print_board).once
        expect(board_mark_if_space_free).to receive(:update_space).twice
        game_mark_if_space_free.mark_if_space_free
      end
    end
  end


  describe '#player_mark_input' do
    subject(:game_player_mark_input) { described_class.new(board_player_mark_input) }
    let(:board_player_mark_input) { instance_double(Board) }
    context 'when the space is inside the board parameters' do
      before do
        allow(game_player_mark_input).to receive(:gets).and_return('A1')
      end
      it 'it returns the space and breaks the loop' do
        message = 'Please enter a single letter and a single digit without spaces.'
        expect(game_player_mark_input).not_to receive(:puts).with(message)
        expect(game_player_mark_input.player_mark_input).to eq('a1')
      end
    end

    context 'when the space is outside of the board parameters once then is inside the parameters' do
      before do
        allow(game_player_mark_input).to receive(:gets).and_return('x4', 'A1')
      end
      it 'it sends the correct message once and then returns the space and breaks the loop' do
        message = 'Please enter a single letter and a single digit without spaces.'
        expect(game_player_mark_input).to receive(:puts).once
        expect(game_player_mark_input).to receive(:puts).with(message).once
        expect(game_player_mark_input.player_mark_input).to eq('a1')
      end
    end
  end
end