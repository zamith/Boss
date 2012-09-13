Boss::Engine.routes.draw do
  mount Citygate::Engine => "/"

  resources :posts do
    collection do
      post 'save', :constraints => { :format => 'json' }, :defaults => { :format => 'json' }
      post 'publish'
      get  'load'
    end

    member do
      post 'publish'
      get 'content'
    end
  end

  resources :banners, :only => [:index]

  namespace :resources, module: nil, as: nil do
    match '/images' => "resources#all_images",
      :as => "all_images",
      :via => :get

    match '/:type' => "resources#create",
      :as => "create_image",
      :via => :post,
    :constraints => { :type => /(image|file)/}
    end
  
    namespace :admin do
      resources :posts, :only => [:index]
      resources :resources do
        collection do
          get 'load'
        end
      end
      resources :banners
    end
end
