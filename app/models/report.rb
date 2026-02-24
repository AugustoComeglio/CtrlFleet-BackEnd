# frozen_string_literal: true

class Report < ApplicationRecord
  def name
    "#{report_types_hash[report_type.to_sym]} desde #{begin_at.to_date.strftime('%d/%m/%Y')} hasta #{end_at.to_date.strftime('%d/%m/%Y')}"
  end

  def report_types_hash
    {
      'vehicles': 'Vehiculos' ,
      'users': 'Usuarios' ,
      'fleets_per_warehouse': 'Flotas de Vehiculos por Deposito' ,
      'spares_per_maintenance_plan': 'Repuestos utilizados por Plan de Mantenimiento' ,
      'spares': 'Repuestos ordenados por stock por Deposito' ,
      'spares_per_vehicle': 'Respuestos utilizados por Vehiculo' ,
      'maintenance_plans': 'Planes de Mantenimiento' ,
      'debates': 'Debates' ,
      'failures': 'Daños' ,
      'fuel_records_per_fleet': 'Costos de Combustibles por Flota' ,
      'kilometer_records_per_fleet': 'Kilometros registrados por Flota' ,
      'gas_stations_ranking': 'Ranking de Estaciones de Servicio mas utilizadas'
    }
  end
end
