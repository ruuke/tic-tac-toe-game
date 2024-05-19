class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.references :player_x, null: false, foreign_key: { to_table: :players }
      t.references :player_o, foreign_key: { to_table: :players }
      t.string :current_turn
      t.string :status

      t.timestamps
    end
  end
end
