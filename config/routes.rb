Rails.application.routes.draw do

  apipie
  devise_for :users
  resources :blogs
  root 'blogs#index'
  get "blog/profile", to: "blogs#profile"
  get "/user/addfriend", to: "blogs#friend"
  get "/user/acc", to: "blogs#accept_friend"
  get "/user/de", to: "blogs#delete_friend"
  resources :blogs do
   resources :comments do
     resources :replies
    end
  end


  resources :blogs, only: [] do
    member do
     get "like", to: "blogs#upvote"
     get "dislike", to: "blogs#downvote"
    end
  end
  namespace :api, :defaults => { :format => 'json' } do
    namespace :v1 do
      resources :registrations do
        post :register_user
        collection do
          post :login
          post :logout
        end
      end
      resources :blogs 
      resources :comments
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
