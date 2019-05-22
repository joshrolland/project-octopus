Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  # TODO: limit onbly to used actions!
  resources :sites do
    collection do
      get 'search'
    end
  end
  resources :students do
    collection do
      get 'search'
    end
  end
  resources :contacts do
    resources :comments, to: 'comments#contact_comment_create'
    collection do
      get 'search'
    end
  end
  resources :user_accounts
  resources :comments

  post '/sites/new', to: 'sites#create'
  post '/students/new', to: 'students#create'
  post '/contacts/new', to: 'contacts#create'
  post '/user_accounts/new', to: 'user_accounts#create'
end
