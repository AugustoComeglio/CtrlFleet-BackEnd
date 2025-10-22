# frozen_string_literal: true

class FuelType < ApplicationRecord
  acts_as_paranoid

  has_many :vehicles, class_name: 'Vehicle', dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
