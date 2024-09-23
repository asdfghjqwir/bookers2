Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about',to: 'homes#about',as: 'about'
 
  devise_for :users
  resources :books,only:[:index ,:show,:create,:edit,:update,:destroy]
  resources :users,only:[:index,:show,:edit,:update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
