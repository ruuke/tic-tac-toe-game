FactoryBot.define do
  factory :game do
    player_x { nil }
    player_o { nil }
    current_turn { "MyString" }
    status { "MyString" }
  end
end
