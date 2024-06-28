Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  scope module: :users do
    resources :posts, only: %i[new create edit update destroy]
    resource :relationships, only: %i[create destroy]
    resource :profile, only: %i[show edit update]
    resources :following_posts, only: %i[index]
  end
  resources :posts, only: %i[index show] do
    resources :likes, only: %i[index create destroy], module: :posts
    resources :comments, only: %i[new create edit update destroy]
  end
  resources :users, only: %i[show]
end
