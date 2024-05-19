class Move < ApplicationRecord
  belongs_to :game
  belongs_to :player

  validates :position, inclusion: { in: 0..8 }
end
