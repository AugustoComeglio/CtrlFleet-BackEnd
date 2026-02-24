# frozen_string_literal: true

module Api
  module V1
    class ReportsController < Api::BaseController
      include ReportsConcern

      before_action :find_report, only: :export_report

      def index
        render json: { data: {} }, status: :ok and return unless report_params

        @report_type = report_params[:report_type]
        @date_range = report_params[:begin_at].to_date.beginning_of_day..report_params[:end_at].to_date.end_of_day

        @report = Report.find_or_create_by(report_type: report_params[:report_type],
                                           begin_at: report_params[:begin_at],
                                           end_at: report_params[:end_at])

        log = collection

        @report.log = log.to_s
        @report.record_ids = log.map { |r| r['id'] }.join(',')

        if @report.save
          render json: { data: { id: @report.id, name: @report.name, log: log } }, status: :ok
        else
          render json: { message: @report.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def report_types
        render json: {
          data: [
            ['vehicles', 'Vehiculos'], ['users', 'Usuarios'],
            ['spares', 'Repuestos ordenados por stock por Deposito'],
            ['maintenance_plans', 'Planes de Mantenimiento'],
            ['debates', 'Debates'],['failures', 'Daños'],
            ['fuel_records_per_fleet', 'Costos de Combustibles por Flota'],
            ['kilometer_records_per_fleet', 'Kilometros registrados por Flota'],
            ['gas_stations_ranking', 'Ranking de Estaciones de Servicio mas utilizadas']
            # ['fleets_per_warehouse', 'Flotas de Vehiculos por Deposito'],
            # ['spares_per_maintenance_plan', 'Repuestos utilizados por Plan de Mantenimiento'],
            # ['spares_per_vehicle', 'Respuestos utilizados por Vehiculo'],
          ]
        }, status: :ok
      end

      private

      def report_params
        params.permit :begin_at, :end_at, :report_type
      end

      def collection
        case @report_type
        when 'vehicles'
          Vehicle.where(created_at: @date_range).as_json(except: %i[vehicle_type_id fuel_type_id warehouse_id manager_id driver_id brand_id model_id updated_at deleted_at], methods: %i[manager_email driver_email brand_name model_name warehouse_name])
        when 'users'
          User.where(created_at: @date_range).as_json(only: %i[id dni email first_name last_name phone created_at], methods: %i[type_name])
        # when 'fleets_per_warehouse'
        #   Fleet.jois(vehicles: :warehouse).where(fleets: { created_at: @date_range }).group(&:'warehouses.name').as_json
        when 'spares'
          SpareWarehouse.where(created_at: @date_range).joins(:spare, :warehouse).order(:quantity, :warehouse_id).map { |sw| { 'id'=> sw.id, 'name'=> sw.spare.name, 'brand_name'=> sw.spare.brand_name, 'stock'=> sw.quantity, 'warehouse'=> sw.warehouse.name } }
        # when 'spares_per_maintenance_plan'
        #   Spare.where(created_at: @date_range).as_json
        # when 'spares_per_vehicle'
        #   Spare.where(created_at: @date_range).as_json
        when 'maintenance_plans'
          MaintenancePlan.where(created_at: @date_range).as_json(only: %i[id name begin_at end_at], methods: %i[user_email maintenances_count failures_count])
        when 'debates'
          Debate.where(begin_at: @date_range).as_json(except: %i[user_id deleted_at], methods: %i[responses_count user_email])
        when 'failures'
          Failure.where(created_at: @date_range).as_json(except: %i[updated_at deleted_at maintenance_plan_id user_id vehicle_id], methods: %i[vehicle_license_plate user_email maintenance_plan_name])
        when 'fuel_records_per_fleet'
          FuelRecord.where(created_at: @date_range).joins(vehicle: :fleet).order('fleets.name').as_json(only: %i[id quantity unit_price observation registered_at], methods: %i[vehicle_license_plate unit_name gas_station_name fuel_type_name])
        when 'kilometer_records_per_fleet'
          KilometerRecord.where(created_at: @date_range).joins(vehicle: :fleet).order('fleets.name').as_json(only: %i[id kms_traveled observation registered_at], methods: %i[vehicle_license_plate unit_name])
        when 'gas_stations_ranking'
          GasStation.where(created_at: @date_range).sort_by { |gs| gs.fuel_records.count }.as_json(only: %i[id name], methods: %i[fuel_records_count last_fuel_record_at])
        end
      end
    end
  end
end
