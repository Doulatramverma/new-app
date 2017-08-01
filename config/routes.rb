Rails.application.routes.draw do

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


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
