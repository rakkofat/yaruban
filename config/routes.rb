Rails.application.routes.draw do
  root 'static_pages#welcome'

  get '/auth/github/callback', to: 'sessions#github'
  get '/sign_out', to: 'sessions#destroy'
end
