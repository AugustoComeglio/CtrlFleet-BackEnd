# frozen_string_literal: true

class UserType < ApplicationRecord
  acts_as_paranoid

  has_many :users, dependent: :destroy
  has_many :user_types_permissions, class_name: 'UserTypePermission', dependent: :destroy
  has_many :permissions, through: :user_types_permissions, class_name: 'Permission', source: :permission

  scope :enabled, -> { where enable_login: true }

  validates :name, presence: true, uniqueness: true
end
