# frozen_string_literal: true

class Image < ApplicationRecord
  acts_as_paranoid

  belongs_to :manager, class_name: 'User'
  belongs_to :user, class_name: 'User', optional: true
  belongs_to :vehicle, class_name: 'Vehicle', optional: true
  belongs_to :spare, class_name: 'Spare', optional: true
  belongs_to :failure, class_name: 'Failure', optional: true

  delegate :email, to: :user, prefix: true, allow_nil: true
  delegate :license_plate, to: :vehicle, prefix: true, allow_nil: true
  delegate :name, to: :spare, prefix: true, allow_nil: true
  delegate :name, to: :failure, prefix: true, allow_nil: true
end
