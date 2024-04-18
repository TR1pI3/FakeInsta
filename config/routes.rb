Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'posts#index'
  resources :posts do
    resources :comments, only: %i[new create destroy]
    resources :likes, only: %i[create destroy]
  end
  get 'profile/:id', to: 'profile#show', as: 'profile'
  post 'profile/follow', to: 'profile#follow'
  delete 'profile/unfollow', to: 'profile#unfollow'
  get 'feed', to: 'feed#index'
end
