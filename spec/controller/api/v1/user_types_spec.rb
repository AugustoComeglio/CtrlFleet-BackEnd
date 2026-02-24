# frozen_string_literal: true

require 'rails_helper'

resource 'Api User Type', type: :documentation do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  header 'Authorization', :authorization

  let(:admin) { create :user_type }
  let(:user) { create :user }
  let(:authorization) { "Bearer #{user.get_doorkeeper_token}" }

  get 'api/v1/user_types' do
    context '200' do
      example 'return email is ok' do
        expected_response = {
          "data": [
              {
                  "id": admin.id,
                  "name": admin.name
              }
            ]
          }

        do_request
        resp = JSON.parse(response_body)

        expect(resp).to eq expected_response
        expect(status).to eq 200
      end
    end
  end
end
