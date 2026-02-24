# frozen_string_literal: true

class StockMovementSpare < ApplicationRecord
  attr_accessor :spare_id, :warehouse_id

  belongs_to :spare_warehouse, class_name: 'SpareWarehouse'

  self.table_name = 'stock_movements_spares'

  after_create :update_stock_to_spare_warehouse

  private

  def update_stock_to_spare_warehouse
    new_stock = spare_warehouse.quantity + quantity
    spare_warehouse.update quantity: new_stock
  end
end
