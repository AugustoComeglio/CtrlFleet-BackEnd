# frozen_string_literal: true

class Warehouse < ApplicationRecord
  acts_as_paranoid

  has_many :spares_warehouses, class_name: 'SpareWarehouse', dependent: :destroy
  has_many :spare, through: :spares_warehouses, class_name: 'Spare', source: :spare

  validates :name, presence: true, uniqueness: true
end
