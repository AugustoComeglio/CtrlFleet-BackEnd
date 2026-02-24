# frozen_string_literal: true

module Api
  module V1
    class MaintenancesController < Api::BaseController
      before_action :find_maintenance, except: %i[index create]

      def index
        @maintenances = Maintenance.all.order(:priority)

        render json: { data: @maintenances.as_json(only: %i[id name description priority begin_at estimated_end_at end_at], methods: %i[state]) },
               status: :ok
      end

      def create
        @maintenance = Maintenance.new maintenance_params
        @maintenance.user_id = current_user_id

        if @maintenance.save
          render json: { data: @maintenance.as_json(except: %i[user_id created_at updated_at deleted_at],
                                                    methods: %i[state vehicle_license_plate maintenance_plan_name]) },
                 status: :ok
        else
          render json: { message: @maintenance.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def show
        if @maintenance
          render json: { data: @maintenance.as_json(except: %i[user_id created_at updated_at deleted_at],
                                                    methods: %i[state vehicle_license_plate maintenance_plan_name]) },
                 status: :ok
        else
          render json: { message: "Mantenimiento #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def update
        if @maintenance.update(maintenance_params)
          render json: { data: @maintenance.as_json(except: %i[user_id created_at updated_at deleted_at],
                                                    methods: %i[state vehicle_license_plate maintenance_plan_name]) },
                                        status: :ok
        else
          render json: { message: @maintenance.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @maintenance.destroy
          render json: { message: 'Mantenimiento eliminado con exito' }, status: :ok
        else
          render json: { message: @maintenance.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def activate
        if @maintenance.update(begin_at: maintenance_params[:begin_at])
          @maintenance.change_state!('en progreso')
          @maintenance.vehicle.change_state!('en reparacion')

          render json: { message: "Mantenimiento #{@maintenance.name} actualizado con exito.
                                   Inicia en #{@maintenance.begin_at.strftime('%d/%m/%Y')}" },
                 status: :ok
        else
          render json: { message: @maintenance.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def deactivate
        if @maintenance.update(end_at: maintenance_params[:end_at])
          @maintenance.change_state!('realizado')
          @maintenance.vehicle.change_state!('activo') unless @maintenance.vehicle.maintenances.map(&:state).include? 'en progreso'

          render json: { message: "Mantenimiento #{@maintenance.name} actualizado con exito.
                                   Finaliza en #{@maintenance.end_at.strftime('%d/%m/%Y')}" },
                 status: :ok
        else
          render json: { message: @maintenance.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def spares
        render json: { data: @maintenance.added_spares }, status: :ok
      end

      def add_spare
        maintenance_spare = MaintenanceSpare.new(maintenance_id: @maintenance.id,
                                                 spare_id: params[:spare][:spare_id],
                                                 quantity: params[:spare][:quantity])

        if maintenance_spare.save
          render json: { message: 'ok' }, status: :ok
        end
      end

      def remove_spare
        maintenance_spare = MaintenanceSpare.find_by(id: params[:spare][:maintenance_spare_id])

        if maintenance_spare.destroy
          render json: { message: 'ok' }, status: :ok
        end
      end

      private

      def find_maintenance
        @maintenance = Maintenance.find_by id: params[:id]
      end

      def maintenance_params
        params.require(:maintenance).permit :name, :description, :priority, :estimated_end_at, :begin_at, :end_at, :maintenance_plan_id, :maintenance_type_id, :vehicle_id
      end
    end
  end
end
