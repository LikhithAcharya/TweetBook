Rails.application.routes.draw do
   root 'welcome#index'

   get 'signup', to: 'users#new'
   get 'login', to: 'sessions#new'
   post 'login', to: 'sessions#create'
   delete 'logout', to: 'sessions#destroy'
   get 'search_friends', to: 'users#search'
   post 'add_friend', to: 'users#add_friend'
   get 'add_friend', to: 'users#add_friend'

   get 'my_friends', to: 'users#my_friends'
   resources :categories, except: [:destroy]
   resources :friendships
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :users, except: [:new]
    resources :users, only: [:show]
    resources :tweets do
    resources :comments
  end


end
