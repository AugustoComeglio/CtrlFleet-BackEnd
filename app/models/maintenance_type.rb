# frozen_string_literal: true

class MaintenanceType < ApplicationRecord
  acts_as_paranoid

  has_many :maintenances, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
