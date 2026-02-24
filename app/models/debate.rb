# frozen_string_literal: true

class Debate < ApplicationRecord
  acts_as_paranoid

  include Debate::Reportable

  belongs_to :user, class_name: 'User'
  has_many :responses, class_name: 'Response', dependent: :destroy

  delegate :email, to: :user, prefix: true

  def started
    {
      started_by: "#{user.try(:first_name)} #{user.try(:last_name)}",
      started_email: user_email,
      photo: user.profile_photo_url
    }
  end

  def last_response
    last_resp_user = responses.order(:created_at).try(:last).try(:user)

    return nil unless last_resp_user

    {
      responsed_by: "#{last_resp_user.try(:first_name)} #{last_resp_user.try(:last_name)}",
      responsed_email: last_resp_user.try(:email),
      created_at: last_resp_user.try(:created_at)
    }
  end

  def responses_count
    responses.count
  end
end
