# frozen_string_literal: true

class UserType < ApplicationRecord
  acts_as_paranoid

  has_many :users
  has_many :user_types_permissions, class_name: 'UserTypePermission', dependent: :destroy
  has_many :permissions, through: :user_types_permissions, class_name: 'Permission', source: :permission

  scope :enabled, -> { where enable_login: true }

  validates :name, presence: { message: I18n.t(:name_field_is_required) },
                   uniqueness: { message: I18n.t(:already_exists_object_with_name, class: 'Tipo de Usuario') }
end
