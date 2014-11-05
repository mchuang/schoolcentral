Rails.application.routes.draw do

  get 'static/home'

  get 'dashboard/index'
  get 'dashboard/admin_dashboard'
  post 'dashboard/admin_dashboard'
  get 'dashboard/new_form'
  post 'dashboard/new_create'

  post 'users/update_address'
  post 'users/update_email'
  post 'users/update_password'
  post 'users/update_phone'

  post 'classrooms/setAttendance'
  post 'classrooms/setGrades'
  get 'classrooms/getClassroom'
  post 'classrooms/editClassroom'

  devise_for :users, 
    :path => '',
    :path_names => {
      :sign_in  => "login",
      :sign_out => "logout",
      :sign_up  => "register"
    }

  root 'static#home'

  resources :users, :classrooms, :assignments

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
