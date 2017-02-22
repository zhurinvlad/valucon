Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :images, only: [:create, :index]
	resources :feedback, only: [:create]
	root to: 'images#index'
end
