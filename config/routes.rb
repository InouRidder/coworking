Rails.application.routes.draw do
  root 'desks#index'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :registrations, skip: %i[registrations], controllers: { confirmations: 'auth/confirmations' }

  resources :registrations, only: %i[new create]
  namespace :requests  do
    get :confirmations, to: 'confirmations#update' # no patch requests in mailers
  end
end
