# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :user_type, class: 'UserType' do
    name         { 'admin' }
    enable_login { true }
  end
end
