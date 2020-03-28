Rails.application.routes.draw do
  resources :currencies, only: [:index, :show]
end
