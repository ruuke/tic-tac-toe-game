Rails.application.routes.draw do
  resources :players, only: [:new, :create]
  resources :games, only: [:new, :show] do
    resources :moves, only: [:create]
  end

  root 'players#new'
end
