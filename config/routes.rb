Rails.application.routes.draw do
  devise_for :users
  root "users#index"

  get '/admin' ,to: "users#admin"
  resources :rewards,only: [:new,:create]
  resources :stores do 
    resources :products do
      member do
        get 'buy_now'
      end
    end
  end

  resources :transactions
  get ':user_id/rewards', to: "users#rewards",as: "user_rewards"
  get ':user_id/points', to: "users#points",as: "user_points"
  get ':user_id/transaction',to: "transactions#index",as: "user_transactions"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
