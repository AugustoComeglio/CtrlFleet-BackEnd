# frozen_string_literal: true
require 'sidekiq/web'


Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  devise_for :users
  use_doorkeeper

  # TODO: ver como agregar esta ruta para tener el dashboard
  #       ahora no se deja por la autenticacion del usuario
  # mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :brands, except: %i[new edit] do
        member do
          get :models
        end
      end
      resources :debates, except: %i[new edit]
      resources :documents, except: %i[new edit]
      resources :enable_notification_types, only: %i[index create update]
      resources :failures, except: %i[new edit] do
        member do
          get :documents
        end
      end
      resources :fleets, except: %i[new edit] do
        member do
          get :vehicles
        end
      end
      resources :fuel_records, except: %i[new edit]
      resources :fuel_types, except: %i[new edit]
      resources :gas_stations, except: %i[new edit]
      resources :images, except: %i[new edit]
      resources :kilometer_records, except: %i[new edit]
      resources :maintenances, except: %i[new edit] do
        member do
          post :activate
          post :deactivate
          get :spares
          put :add_spare
          put :remove_spare
        end
      end
      resources :maintenance_plans, except: %i[new edit] do
        member do
          get :maintenances
          get :failures
        end
      end
      resources :maintenance_types, except: %i[new edit]
      resources :models, except: %i[new edit]
      resources :notifications, only: %i[index show update]
      resources :notification_types, except: %i[new edit]
      resources :permissions, except: %i[new edit] do
        collection do
          get :report_types
        end
      end
      resource :recover_password, only: %i[create update], controller: 'recover_password'
      resources :reports, only: %i[index] do
        collection do
          get :report_types
        end
        member do
          put :export_report
        end
      end
      resources :responses, except: %i[new edit]
      resources :spares, except: %i[new edit] do
        collection do
          get :availables
        end
      end
      resources :state_documents, except: %i[new edit]
      resources :state_maintenances, except: %i[new edit]
      resources :state_vehicles, except: %i[new edit]
      resources :stock_movement_spares, only: %i[create update create]
      resources :units, except: %i[new edit]
      resources :unit_types, except: %i[new edit] do
        member do
          get :units
        end
      end
      resources :users, except: %i[new edit] do
        member do
          get :permissions
          get :documents
        end
      end
      resources :user_types, except: %i[new edit] do
        member do
          post :add_permission
          post :remove_permission
          get :users
        end
      end
      resources :vehicles, except: %i[new edit] do
        member do
          get :fuel_records
          get :kilometer_records
          get '/monitoring', to: 'vehicles#fuel_records_monitoring', as: 'monitoring'
          get :maintenances
          get :failures
          get :images
          get :documents
        end
      end
      resources :vehicle_types, except: %i[new edit]
      resources :warehouses, except: %i[new edit]
    end
  end
end
