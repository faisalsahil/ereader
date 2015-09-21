EreaderSync::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  authenticated :user do
    # root :to => 'author_books#new'
    root :to => 'users#index'
    # root :to => 'devise/sessions#new'
  end
    # root :to => 'users#index'
    root :to => 'author_books#new'
  # root :to => "devise/sessions#new"

  resources :mandrill_settings
  resources :Stripeconnections
  resources :mclists do
    collection do
      get :modify_list
    end
    member do
      put :load_group1
    end
  end
  resources :scheduleings do
    collection do
      get :report
      get :schedule_range
      get :report_range
    end
  end
  resources :author_books do
    member do
      put :reject_status
      put :update_status
      get :edit_date
      put :update_date
    end
    collection do
      get :aaa
      get :bbb
    end
    resources :payments
    resources :scheduleings
  end

  resources :xmlrpcs
  resources :pricings 
  # do
  #   collection do
  #     get :crone_wordpress
  #   end
  # end

  resources :smtp_settings
  resources :key_mandrills
  resources :manages do
    collection do
      post :search_subscriber
      get :unsubscribe
    end
  end

  resources :apisettings do
    collection do
      get :load_list
      get :load_template
      get :stripe_request
      get :load_groups
    end
  end





  devise_for :users
  resources :users

  resources :upload_csvs
  resources :csvs

  resources :author_books

  resources :apisettings do
    collection do
      get :load_list
    end
  end

end