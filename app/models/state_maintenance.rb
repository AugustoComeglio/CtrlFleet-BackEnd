# frozen_string_literal: true

class StateMaintenance < ApplicationRecord
  acts_as_paranoid

  validates :name, presence: true, uniqueness: true
end
