# frozen_string_literal: true

class Document < ApplicationRecord
  acts_as_paranoid

  belongs_to :manager, class_name: 'User'
  belongs_to :user, class_name: 'User'
  belongs_to :vehicle, class_name: 'Vehicle'
  belongs_to :failure, class_name: 'Failure'

  validates :code, presence: true, uniqueness: true
end
