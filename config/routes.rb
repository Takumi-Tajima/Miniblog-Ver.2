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
    resource :likes, only: %i[create destroy], module: :posts
  end
end
