Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  scope 'dashboard' do
    resources :modulepages, path: "module", except: [:show]
    resources :roles, path: "role", except: [:show]
    resources :users, except: [:show]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'
end
