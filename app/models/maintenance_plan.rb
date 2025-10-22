# frozen_string_literal: true

class MaintenancePlan < ApplicationRecord
  acts_as_paranoid

  has_many :maintenances, dependent: :destroy
  belongs_to :user, class_name: 'User'

  validates :name, presence: true, uniqueness: true
end
