# frozen_string_literal: true

class Debate < ApplicationRecord
  acts_as_paranoid

  belongs_to :user, class_name: 'User'

  # TODO: add automatically code generator
  validates :code, presence: true, uniqueness: true
end
