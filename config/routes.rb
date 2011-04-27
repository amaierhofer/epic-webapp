EpicWebapp::Application.routes.draw do
  get "session/new"

  root :to => "welcome#showcase"
  match 'welcome/xmpp'
  match 'welcome/mockups'

  match 'about', :to => 'about#index'
  match 'about/artifacts' 
  match 'about/technology' 
  match 'about/use_cases'

  match 'mobileapps', :to => "mobileapps#index", :as => :apps_home
  match 'mobileapps/design'
  match 'mobileapps/dialog', :as => :dialog
  match 'mobileapps/qrcode'
  match 'mobileapps/ringit'
  match 'mobileapps/browserhistory'
  match 'mobileapps/makeit'

  match 'test', :to => 'jasmine#index', :as => :jasmine_index
  match 'test/docs', :to => 'jasmine#docs', :as => :jasmine_docs
  match 'test/disco', :to => 'jasmine#disco', :as => :jasmine_disco
  match 'test/webos', :to => 'jasmine#webos', :as => :jasmine_webos
  match 'test/compass', :to => 'jasmine#compass', :as => :jasmine_compass

  resources :users do
      get 'appstore', :on => :collection
      get 'checkname', :on => :collection
  end
  resources :sessions
  get "logout" => "sessions#destroy", :as => "log_out"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
