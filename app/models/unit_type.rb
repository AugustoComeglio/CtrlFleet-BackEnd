# frozen_string_literal: true

class UnitType < ApplicationRecord
  acts_as_paranoid

  has_many :units, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
