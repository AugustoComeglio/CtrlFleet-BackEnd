# frozen_string_literal: true

class Brand < ApplicationRecord
  acts_as_paranoid

  has_many :models, class_name: 'Model', dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
