# frozen_string_literal: true

class MaintenanceSpare < ApplicationRecord
  belongs_to :maintenance, class_name: 'Maintenance'
  belongs_to :spare, class_name: 'Spare'

  after_create :generate_stock_movement
  before_destroy :revert_stock_movement

  private

  def generate_stock_movement
    index = 0

    spares_with_stock.sort_by { |sw| sw.warehouse_id == maintenance.vehicle.warehouse.id ? 1 : sw.warehouse_id }.each do |sw|
      next if index == quantity
      qty = (index.zero? ? quantity : (quantity - index))

      if sw.quantity >= qty
        create_stock_movement(sw.id, -qty)
        index += qty
      elsif sw.quantity < qty
        create_stock_movement(sw.id, -sw.quantity)
        index += sw.quantity
      end
    end
  end

  def revert_stock_movement
    create_stock_movement(spares_with_stock.where(warehouse_id: maintenance.vehicle.warehouse.id).first.id, quantity)
  end

  def spares_with_stock
    SpareWarehouse.where('quantity IS NOT NULL OR quantity > 0')
                  .where(spare_id: spare.id)
  end

  def create_stock_movement(sw_id, qty)
    StockMovementSpare.create spare_warehouse_id: sw_id, quantity: qty
  end
end
