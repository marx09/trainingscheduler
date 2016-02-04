Rails.application.routes.draw do
  root 'trainings#index'
  devise_for :users
  get 'users/:id' => 'users#show', as: :user
  
  resources :groups
  put 'groups/:id/add_user/:user' => 'groups#add_user', as: :add_user_to_group
  put 'groups/:id/remove_user/:user' => 'groups#remove_user', as: :remove_user_from_group
  
  resources :excercises
  
  resources :trainings
  get 'trainings/:id/plan_content' => 'trainings#plan_content', as: :plan_training_content
  post 'trainings/:id/save_content' => 'trainings#save_content', as: :save_training_content
  get 'trainings/calendar_move/:year/:month/:day' => 'trainings#calendar_move', as: :calendar_move
  get 'trainings/:id/users' => 'trainings#users', as: :training_users
  post 'trainings/:id/save_users' => 'trainings#save_users', as: :save_training_users
  post 'trainings/save_user_result' => 'trainings#save_user_result', as: :save_user_result
  post 'trainings/save_training_user_result' => 'trainings#save_training_user_result', as: :save_training_user_result
  
  resources :training_prototypes
  put 'training_prototypes/:id/create_training/:date' => 'training_prototypes#create_from', as: :create_training_from_prototype
  
  resources :training_prototypes
  
  get 'results/excercise/:id/user/:user/show' => 'results#show_excercise', as: :results_excercise_show
  get 'results/trainings/:user/show' => 'results#show_training_results', as: :results_training_show
  
  resources :templates
  post 'templates/:id/save_content' => 'templates#save_content', as: :save_template_content
  #delete 'templates'
  
  
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
