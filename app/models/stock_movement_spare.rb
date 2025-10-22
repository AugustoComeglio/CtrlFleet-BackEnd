# frozen_string_literal: true

class StockMovementSpare < ApplicationRecord
  belongs_to :spare_warehouse, class_name: 'SpareWarehouse'

  self.table_name = 'stock_movements_spares'
end
