# frozen_string_literal: true

class Permission < ApplicationRecord
  acts_as_paranoid

  has_many :user_types_permissions, class_name: 'UserTypePermission', dependent: :destroy
  has_many :user, through: :user_types_permissions, class_name: 'User', source: :user
  has_many :report_types_permissions, class_name: 'ReportTypePermission', dependent: :destroy

  validates :action, presence: true
  validates :section, presence: true
end
