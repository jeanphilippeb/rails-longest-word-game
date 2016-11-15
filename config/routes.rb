Rails.application.routes.draw do
  get '/game', to: 'computer#game'
  get '/score', to: 'computer#score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
