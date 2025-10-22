# frozen_string_literal: true

class Unit < ApplicationRecord
  acts_as_paranoid

  belongs_to :unit_type, class_name: 'UnitType'
  alias type unit_type

  delegate :name, to: :type, prefix: true

  validates :name, presence: true, uniqueness: true
end
