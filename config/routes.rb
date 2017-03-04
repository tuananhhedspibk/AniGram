Rails.application.routes.draw do
	root 'static_pages#home'
	get '/signup', to: 'users#new'
	post '/signup', to: 'users#create'	# named routes
	get '/login', to: 'sessions#new'
	post '/login', to: 'sessions#create'
	delete '/logout', to: 'sessions#destroy'
	get '/index', to: 'users#index'
	resources :users do
		member do
			get :following, :followers
		end
	end
	resources :users
	resources :microposts,		only: [:create, :destroy]
	resources :relationships,	only: [:create, :destroy]
end