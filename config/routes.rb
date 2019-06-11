Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  scope 'dashboard' do
    get '/', to: 'dashboard#index', as: 'dashboard'
    post '/choose-role', to: 'dashboard#choose_role', as: 'choose_role'
    resources :modulepages, path: "module", except: [:show]
    resources :roles, path: "role", except: [:show]
    resources :users, except: [:show]
  end

  

  root to: 'home#index'
end
