# frozen_string_literal: true

class GasStation < ApplicationRecord
  acts_as_paranoid

  include GasStation::Reportable

  has_many :fuel_records, class_name: 'FuelRecord', dependent: :destroy

  validates :name, presence: { message: I18n.t(:name_field_is_required) },
                   uniqueness: { message: I18n.t(:already_exists_object_with_name, class: 'Estacion de Servicio') }

  def fuel_records_count
    fuel_records.try(:count)
  end

  def last_fuel_record_at
    fuel_records.order(:registered_at).pluck(:registered_at).last&.strftime('%d/%m/%Y')
  end
end
