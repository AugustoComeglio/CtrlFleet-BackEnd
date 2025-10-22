# frozen_string_literal: true

class EnableNotificationType < ApplicationRecord
  belongs_to :notification_type, class_name: 'NotificationType'

  validates :enable, presence: true
end
