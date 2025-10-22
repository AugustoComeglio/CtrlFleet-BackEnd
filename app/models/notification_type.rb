# frozen_string_literal: true

class NotificationType < ApplicationRecord
  acts_as_paranoid

  validates :name, presence: true, uniqueness: true
end
