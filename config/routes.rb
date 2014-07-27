Rails.application.routes.draw do

  devise_for :users

  resources :boards do
    resources :updates
  end

  resources :clients
  resources :curators do
    resource :template, controller: :templates do
      resources :elements
    end
  end

  root 'home#index'
end
