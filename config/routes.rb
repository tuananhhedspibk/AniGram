Rails.application.routes.draw do
	root 'static_pages#home'
	get '/signup', to: 'users#new'
	post '/signup', to: 'users#create'	# named routes
	get '/login', to: 'sessions#new'
	post '/login', to: 'sessions#create'
	delete '/logout', to: 'sessions#destroy'
	resources :users
	resources :microposts,		only: [:create, :destroy]
end