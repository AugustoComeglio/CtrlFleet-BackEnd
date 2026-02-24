# frozen_string_literal: true

class SpareWarehouse < ApplicationRecord
  include SpareWarehouse::Reportable

  belongs_to :spare, class_name: 'Spare'
  belongs_to :warehouse, class_name: 'Warehouse'

  self.table_name = 'spares_warehouses'
end
