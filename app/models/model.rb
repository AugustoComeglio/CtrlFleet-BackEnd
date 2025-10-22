# frozen_string_literal: true

class Model < ApplicationRecord
  acts_as_paranoid

  belongs_to :brand, class_name: 'Brand'
  delegate :name, to: :brand, prefix: true

  validates :name, presence: true, uniqueness: { scope: :brand }
end
