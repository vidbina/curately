Rails.application.routes.draw do

  devise_for :users

  resources :boards, only: [:index, :show, :new, :edit, :create, :update, :destroy] do
    resources :updates
  end

  resources :clients
  resources :curators do
    resource :template, controller: :templates do
      resources :elements
    end
  end

  root 'curators#index'
end
