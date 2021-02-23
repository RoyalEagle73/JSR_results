Rails.application.routes.draw do
  resources :users
  resources :scores
  resources :semesters
  resources :students
  resources :subjects
  get "home/login"
  post "home/login"
  get 'home/index'
  root  "home#index"
  get "home/logout"
  get "home/admin"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Routes
end
