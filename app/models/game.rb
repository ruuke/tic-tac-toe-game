class Game < ApplicationRecord
  belongs_to :player_x, class_name: 'Player'
  belongs_to :player_o, class_name: 'Player', optional: true

  enum status: { waiting_for_player: 'waiting_for_player', in_progress: 'in_progress', finished: 'finished' }
end

