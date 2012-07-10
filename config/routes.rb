Boss::Engine.routes.draw do
  mount Citygate::Engine => "/"

  resources :posts

  namespace :resources, :module => nil, :as => nil do
    match '/images' => "resources#all_images",
      :as => "all_images",
      :via => :get
    
    match '/:type' => "resources#create",
      :as => "create_image",
      :via => :post,
      :constraints => { :type => /(image|file)/}
  end

end
