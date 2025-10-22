# frozen_string_literal: true

class Spare < ApplicationRecord
  acts_as_paranoid

  has_one :brand, dependent: :destroy
  has_one :image, dependent: :destroy

  has_many :spares_warehouses, class_name: 'SpareWarehouse', dependent: :destroy
  has_many :warehouse, through: :spares_warehouses, class_name: 'Warehouse', source: :warehouse

  validates :name, presence: true, uniqueness: true
end
