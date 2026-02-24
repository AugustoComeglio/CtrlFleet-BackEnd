# frozen_string_literal: true

class Unit < ApplicationRecord
  acts_as_paranoid

  belongs_to :unit_type, class_name: 'UnitType', optional: true
  alias type unit_type

  delegate :name, to: :type, prefix: true, allow_nil: true

  validates :name, presence: { message: I18n.t(:name_field_is_required) },
                   uniqueness: { message: I18n.t(:already_exists_object_with_name, class: 'Unidad') }
end
