# frozen_string_literal: true

class Warehouse < ApplicationRecord
  acts_as_paranoid

  has_many :spares_warehouses, class_name: 'SpareWarehouse', dependent: :destroy
  has_many :spares, through: :spares_warehouses, class_name: 'Spare', source: :spare

  validates :name, presence: { message: I18n.t(:name_field_is_required) },
                   uniqueness: { message: I18n.t(:already_exists_object_with_name, class: 'Deposito') }
end
