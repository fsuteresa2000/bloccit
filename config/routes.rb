Rails.application.routes.draw do

  resources :topics do
    resources :sponsored_posts, only: [:show, :new, :create, :edit, :update, :destroy]
    resources :posts, except: [:index]
  end

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
