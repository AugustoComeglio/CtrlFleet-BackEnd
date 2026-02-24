# frozen_string_literal: true

class EnableNotificationType < ApplicationRecord
  belongs_to :notification_type, class_name: 'NotificationType'
  belongs_to :user, class_name: 'User'

  delegate :name, to: :notification_type, prefix: true
end
