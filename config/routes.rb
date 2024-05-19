Rails.application.routes.draw do
  resources :games, only: [:create, :show] do
    member do
      post 'join'
    end

    resources :moves, only: [:create]
  end
end
