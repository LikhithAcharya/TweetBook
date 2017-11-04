Rails.application.routes.draw do
   root 'welcome#index'

   get 'signup', to: 'users#new'
   get 'login', to: 'sessions#new'
   post 'login', to: 'sessions#create'
   delete 'logout', to: 'sessions#destroy'

   resources :categories, except: [:destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :users, except: [:new]
    resources :tweets do
    resources :comments
  end


end
