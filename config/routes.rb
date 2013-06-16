SmplNote::Application.routes.draw do
	
	namespace :api, defaults: {format: 'json'} do

		namespace :v1 do
			resources :sessions
			resources :users
			resources :notes
		end
	end

	get "sessions/create" => "sessions#create", :as => "logging_in"
	
	get "sign_up" => "users#new", :as => "sign_up"
	get "log_in" 	=> "sessions#new", 		:as => "log_in"
	get "log_out" 	=> "sessions#destroy", 	:as => "log_out"

	resources :users, :has_many => :notes
	resources :sessions
	resources :notes

	root :to => "sessions#new"
end
