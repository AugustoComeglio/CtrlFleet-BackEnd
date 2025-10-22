# frozen_string_literal: true

class Notification < ApplicationRecord
  acts_as_paranoid

  belongs_to :user, class_name: 'User'
  belongs_to :notification_type, class_name: 'NotificationType'
end
