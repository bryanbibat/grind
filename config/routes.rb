Grind::Application.routes.draw do
  root :to => "home#index"

  devise_for :users

  namespace :admin do
    resources :missions do
      resources :loots
    end
    resources :items
  end

  resources :missions do
    member do
      post "perform"
    end
  end

  resource :inventory

  resource :profile do
    post "upgrade_melee"
    post "upgrade_ranged"
    post "upgrade_defense"
    post "upgrade_agility"
    post "upgrade_cunning"
  end

  resources :research_projects do
    member do
      post "perform"
    end
  end
end
