# frozen_string_literal: true

class Image < ApplicationRecord
  acts_as_paranoid

  belongs_to :manager, class_name: 'User'
  belongs_to :user, class_name: 'User'
  belongs_to :vehicle, class_name: 'Vehicle'
  belongs_to :spare, class_name: 'Spare'
end
