Rails.application.routes.draw do
  resources :products
  post '/search' => 'products#search', as: 'search'
  post '/possearch' => 'products#possearch', as: 'possearch'

  post '/cameraicon' => 'products#cameraicon', as: 'cameraicon'

  post '/save_image' => 'products#save_image', as: 'save_image'


  post '/category' => 'products#category', as: 'category'
  post '/subcategory' => 'products#subcategory', as: 'subcategory'
  post '/manufacturer' => 'products#manufacturer', as: 'manufacturer'
  post '/posinfo' => 'products#posinfo', as: 'posinfo'
  post '/positemsonly' => 'products#positemsonly', as: 'positemsonly'

  post '/poslocation' => 'products#poslocation', as: 'poslocation'
  post '/itemsales' => 'products#item_sales', as: 'itemsales'
  post '/saleitems' => 'products#sale_items', as: 'saleitems'

  post '/poscategory' => 'products#poscategory', as: 'poscategory'
  post '/index' => 'products#index', as: 'index'

  get '/posadmin/images' => 'posadmin#images', as: 'posadminimages'
  post '/posadmin/images' => 'posadmin#images', as: 'posadminimage'

  post '/posadmin/save_image' => 'posadmin#save_image', as: 'possaveimage'


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
