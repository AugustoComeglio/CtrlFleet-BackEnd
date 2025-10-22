# frozen_string_literal: true

class KilometerRecord < ApplicationRecord
  acts_as_paranoid

  belongs_to :vehicle, class_name: 'Vehicle'
  belongs_to :unit, class_name: 'Unit'

  delegate :name, to: :unit, prefix: true
  delegate :license_plate, to: :vehicle, prefix: true

  validates :registered_at, :kms_traveled, presence: true
end
