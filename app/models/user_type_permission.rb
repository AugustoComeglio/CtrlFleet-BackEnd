# frozen_string_literal: true

class UserTypePermission < ApplicationRecord
  belongs_to :user_type, class_name: 'UserType'
  belongs_to :permission, class_name: 'Permission'

  self.table_name = 'user_types_permissions'
end
