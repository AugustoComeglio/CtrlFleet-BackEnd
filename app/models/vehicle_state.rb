# frozen_string_literal: true

class VehicleState < ApplicationRecord
  belongs_to :vehicle, class_name: 'Vehicle'
  belongs_to :state_vehicle, class_name: 'StateVehicle'
end
