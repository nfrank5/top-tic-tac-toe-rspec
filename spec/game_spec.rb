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
        invalid_input = 'Name1234567890'
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
    subject(:game_placing_marks) { described_class.new }
    #let(:board_placing_marks) { instance_double(Board) }

    before do
      #allow(board_placing_marks).to receive(:print_board).and_return(nil)
      #allow(game_placing_marks).to receive(:puts)
      #allow(game_placing_marks).to receive(:player_mark_input).and_return('a1')
      #allow(game_placing_marks).to receive(:mark_if_space_free)
      #allow(board_placing_marks).to receive(:check_for_winner)
    end

    xit 'breaks the loop after 9 times' do
      expect(game_placing_marks).to receive(:mark_if_space_free).exactly(9).times
      game_placing_marks.placing_marks
    end
  end


end