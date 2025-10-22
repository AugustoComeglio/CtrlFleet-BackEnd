# frozen_string_literal: true

class Fleet < ApplicationRecord
  acts_as_paranoid

  belongs_to :manager, class_name: 'User'
  has_many :vehicles, class_name: 'Vehicle', dependent: :destroy

  validates :name, presence: true, uniqueness: true

  delegate :email, to: :manager, prefix: true

  def vehicles_json
    vehicles.as_json only: %i[id license_plate color production_year],
                     methods: %i[brand_name model_name warehouse_name driver_email]
  end

  def vehicles_count
    vehicles.count
  end
end
