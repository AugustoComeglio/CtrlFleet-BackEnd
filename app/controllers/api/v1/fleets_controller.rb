# frozen_string_literal: true

module Api
  module V1
    class FleetsController < Api::BaseController
      before_action :find_fleet, only: %i[show update destroy vehicles]

      def index
        @fleets = Fleet.all.order(:name)

        render json: { data: @fleets.as_json(only: %i[id name code], methods: %i[manager_email vehicles_count]) },
               status: :ok
      end

      def create
        @fleet = Fleet.new fleet_params
        @fleet.manager_id = current_user_id

        if @fleet.save
          render json: { data: @fleet.as_json(only: %i[id name code], methods: %i[manager_email vehicles_json]) },
                 status: :ok
        else
          render json: { message: @fleet.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def show
        if @fleet
          render json: { data: @fleet.as_json(only: %i[id name code], methods: %i[manager_email vehicles_json]) },
                 status: :ok
        else
          render json: { message: "No se encontro Flota de Vehiculos con el identificador #{params[:id]}" },
                 status: :not_found
        end
      end

      def update
        if @fleet.update fleet_params
          render json: { data: @fleet.as_json(only: %i[id name code], methods: %i[manager_email vehicles_json]) },
                 status: :ok
        else
          render json: { message: @fleet.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @fleet.destroy
          render json: { message: 'Flota de Vehiculos eliminada con exito' }, status: :ok
        else
          render json: { message: @fleet.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def vehicles
        render json: { data: @fleet.vehicles.as_json(only: %i[id license_plate], methods: %i[brand_name model_name]) },
               status: :ok
      end

      private

      def find_fleet
        @fleet = Fleet.find_by id: params[:id]
      end

      def fleet_params
        params.require(:fleet).permit :name, :code
      end
    end
  end
end
