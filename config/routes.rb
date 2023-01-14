Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace "api" do
    resources :products do
      collection do
        #products/product_id/get_by_name
         get 'get_by_name'
      end
    end
    resources :categories do
      collection do
        get 'get_by_name'
      end
    end
  end

  scope 'api' do
    mount_devise_token_auth_for 'User', at: 'auth'
  end
end
