# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :user, class: 'User' do
    email                 { FFaker::Internet.email }
    password              { '123123' }
    password_confirmation { '123123' }
    first_name            { 'John' }
    last_name             { 'Wick' }
    dni                   { '40123987' }
    phone                 { '2615237523' }
    user_type_id          { create(:user_type).id }
  end
end
