Rails.application.routes.draw do
  namespace :api, format: "json" do
    namespace :v1 do
      resources :article
    end
  end

  resources :article
  root to: "article#index"

  mount_devise_token_auth_for "User", at: "auth"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
