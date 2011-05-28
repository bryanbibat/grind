Grind::Application.routes.draw do
  root :to => "home#index"

  devise_for :users

  namespace :admin do
    resources :missions
    resources :items
  end

  resources :missions do
    member do
      post "perform"
    end
  end

  resource :profile do
    post "upgrade_melee"
    post "upgrade_ranged"
    post "upgrade_defense"
    post "upgrade_agility"
    post "upgrade_cunning"
  end

end
