# frozen_string_literal: true

class Spare < ApplicationRecord
  acts_as_paranoid

  belongs_to :brand, class_name: 'Brand'
  has_many :images, class_name: 'Image', dependent: :destroy

  has_many :spares_warehouses, class_name: 'SpareWarehouse', dependent: :destroy
  has_many :warehouses, through: :spares_warehouses, class_name: 'Warehouse', source: :warehouse

  has_many :maintenance_spares, class_name: 'MaintenanceSpare', dependent: :destroy
  has_many :maintenances, through: :maintenance_spares, class_name: 'Maintenance', source: :maintenance

  validates :name, presence: { message: I18n.t(:name_field_is_required) },
                   uniqueness: { message: I18n.t(:already_exists_object_with_name, class: 'Repuesto') }

  delegate :name, to: :brand, prefix: true, allow_nil: true
  delegate :url, to: :image, prefix: true, allow_nil: true

  scope :in_stock, -> { includes(:spares_warehouses).where.not(spares_warehouses: { quantity: nil }) }

  def count_in_stock
    spares_warehouses.map do |sw|
      {
        warehouse: sw.warehouse.name,
        quantity: sw.quantity
      }
    end
  end

  def images_json
    images.map do |img|
      {
        id: img.try(:id),
        url: img.url
      }
    end
  end

  def total_count
    spares_warehouses.sum(&:quantity)
  end
end
