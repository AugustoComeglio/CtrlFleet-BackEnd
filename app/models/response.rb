# frozen_string_literal: true

class Response < ApplicationRecord
  acts_as_paranoid

  belongs_to :user, class_name: 'User'
  belongs_to :debate, class_name: 'Debate'
end
