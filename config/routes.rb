Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  devise_for :users
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      resources :brands, except: %i[new edit] do
        member do
          get :models
        end
      end
      resources :debates, except: %i[new edit]
      resources :failures, except: %i[new edit]
      resources :fleets, except: %i[new edit] do
        member do
          get :vehicles
        end
      end
      resources :fuel_records, except: %i[new edit]
      resources :fuel_types, except: %i[new edit]
      resources :gas_stations, except: %i[new edit]
      resources :maintenances, except: %i[new edit]
      resources :maintenance_plans, except: %i[new edit]
      resources :maintenance_types, except: %i[new edit]
      resources :models, except: %i[new edit]
      resources :permissions, except: %i[new edit] do
        collection do
          get :report_types
        end
      end
      resources :reports, except: %i[new edit]
      resources :responses, except: %i[new edit]
      resources :spares, except: %i[new edit]
      resources :units, except: %i[new edit]
      resources :unit_types, except: %i[new edit] do
        member do
          get :units
        end
      end
      resources :users, except: %i[new edit]
      resources :user_types, except: %i[new edit] do
        member do
          post :add_permission
          get :users
        end
      end
      resources :vehicles, except: %i[new edit] do
        member do
          get :fuel_records
          get :kilometer_records
          get '/monitoring', to: 'vehicles#fuel_records_monitoring', as: 'monitoring'
        end
      end
      resources :vehicle_types, except: %i[new edit]
      resources :warehouses, except: %i[new edit]
    end
  end
end
