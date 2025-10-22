# frozen_string_literal: true

class GasStation < ApplicationRecord
  acts_as_paranoid

  has_many :fuel_records, class_name: 'FuelRecord', dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
