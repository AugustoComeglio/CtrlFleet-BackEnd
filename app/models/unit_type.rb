# frozen_string_literal: true

class UnitType < ApplicationRecord
  acts_as_paranoid

  has_many :units, dependent: :destroy

  validates :name, presence: { message: I18n.t(:name_field_is_required) },
                   uniqueness: { message: I18n.t(:already_exists_object_with_name, class: 'Tipo de Unidad') }
end
