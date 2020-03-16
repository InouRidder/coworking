Rails.application.routes.draw do
  devise_for :registrations

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root 'pages#home'

  namespace :requests  do
    get :confirmations, to: 'confirmations#update' # no patch requests in mailers
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
