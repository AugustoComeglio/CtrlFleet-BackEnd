# frozen_string_literal: true

class Model < ApplicationRecord
  acts_as_paranoid

  belongs_to :brand, class_name: 'Brand'
  delegate :name, to: :brand, prefix: true

  validates :name, presence: { message: I18n.t(:name_field_is_required) },
                   uniqueness: { message: I18n.t(:already_exists_object_with_name, class: 'Modelo') }
end
