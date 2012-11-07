Boss::Engine.routes.draw do
  mount Citygate::Engine => "/"

  resources :posts, :path => "blog" do
    collection do
      post 'save', :constraints => {:format => 'json'}, :defaults => {:format => 'json'}
      post 'publish'
      get  'load'
    end

    member do
      post 'publish'
      get 'content'
    end
  end

  namespace :admin do
    resources :banners
    resources :posts, :path => "blog"
    resources :resources do
      collection do
        get 'load'
      end
    end
  end

  namespace :resources, module: nil, as: nil do
    match '/images' => "resources#all_images",
      :as => "all_images",
      :via => :get

    match '/:type' => "resources#create",
      :as => "create_image",
      :via => :post,
      :constraints => {:type => /(image|file)/}
  end

end
