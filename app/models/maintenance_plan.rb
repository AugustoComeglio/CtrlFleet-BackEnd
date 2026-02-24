# frozen_string_literal: true

class MaintenancePlan < ApplicationRecord
  acts_as_paranoid

  include MaintenancePlan::Reportable

  has_many :maintenances, dependent: :destroy
  has_many :failures, dependent: :destroy
  belongs_to :user, class_name: 'User'

  delegate :email, to: :user, prefix: true, allow_nil: true

  validates :name, presence: { message: I18n.t(:name_field_is_required) },
                   uniqueness: { message: I18n.t(:already_exists_object_with_name, class: 'Plan de Mantenimiento') }

  def maintenances_count
    maintenances.count
  end

  def failures_count
    failures.count
  end
end
