Boss::Engine.routes.draw do
  mount Citygate::Engine => "/"

  resources :posts
end
