user_types_attributes = [
  { name: 'admin', enale_login: true },
  { name: 'conductor', enale_login: true },
  { name: 'administrador', enale_login: true },
  { name: 'mecanico', enale_login: true },
  { name: 'usuario', enale_login: true }
]
user_types_attributes.each { |attributes| UserType.find_or_create_by(attributes) }

# user = User.find_or_initialize_by
# user.email = 'ctrlfleet@gmail.com'
# user.dni = '12123123'
# user.first_name = 'Ctrl'
# user.last_name = 'Fleet'
# user.phone = '2616603370'
# user.password = '123123'
# user.password_confirmation = '123123'
# user.user_type_id = UserType.find_by(name: 'admin').id

maintenance_types_attributes = [
  { name: 'control' },
  { name: 'reparacion' }
]
maintenance_types_attributes.each { |attributes| MaintenanceType.find_or_create_by(attributes) }

fuel_types_attributes = [
  { name: 'nafta' },
  { name: 'diesel' },
  { name: 'gnc' }
]
fuel_types_attributes.each { |attributes| FuelType.find_or_create_by(attributes) }

notification_types_attributes = [
  { name: 'popup' },
  { name: 'mail' }
]
notification_types_attributes.each { |attributes| NotificationType.find_or_create_by(attributes) }

unit_types_attributes = [
  { name: 'liquido' },
  { name: 'distancia' }
]
unit_types_attributes.each { |attributes| UnitType.find_or_create_by(attributes) }

distancia_id = UnitType.find_by(name: 'distancia').id
liquido_id = UnitType.find_by(name: 'liquido').id

units_attributes = [
  { unit_type_id: distancia_id, name: 'kilometros' },
  { unit_type_id: distancia_id, name: 'millas' },
  { unit_type_id: distancia_id, name: 'pies' },
  { unit_type_id: distancia_id, name: 'centimetros' },
  { unit_type_id: distancia_id, name: 'milimetros' },
  { unit_type_id: distancia_id, name: 'metros' },
  { unit_type_id: liquido_id,   name: 'litros' },
  { unit_type_id: liquido_id,   name: 'centimetros cubicos' }
]
units_attributes.each { |attributes| Unit.find_or_create_by(attributes) }

vehicle_types_attributes = [
  { name: 'auto' },
  { name: 'camion' },
  { name: 'camioneta' },
  { name: 'hidro grua' },
  { name: 'retro escabadora' },
  { name: 'remis' },
  { name: 'taxi' },
  { name: 'moto' },
  { name: 'bicicleta' }
]
vehicle_types_attributes.each { |attributes| VehicleType.find_or_create_by(attributes) }

state_maintenances_attributes = [
  { name: 'pendiente' },
  { name: 'en progreso' },
  { name: 'realizado' }
]
state_maintenances_attributes.each { |attributes| StateMaintenance.find_or_create_by(attributes) }

state_documents_attributes = [
  { name: 'vigente' },
  { name: 'expirado' }
]
state_documents_attributes.each { |attributes| StateDocument.find_or_create_by(attributes) }

state_vehicles_attributes = [
  { name: 'activo' },
  { name: 'en reparacion' },
  { name: 'dañado' },
  { name: 'inactivo' }
]
state_vehicles_attributes.each { |attributes| StateVehicle.find_or_create_by(attributes) }