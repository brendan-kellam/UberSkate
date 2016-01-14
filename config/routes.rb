Rails.application.routes.draw do
  
  resources :posts
  

  #default root set to index. 
  get 'posts/:id/delete' => 'posts#delete', :as => :products_delete
  get 'usage' => 'posts#usage'

  devise_for :users

  root 'posts#index'

end
