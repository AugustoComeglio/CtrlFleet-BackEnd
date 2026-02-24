# frozen_string_literal: true

class Response < ApplicationRecord
  acts_as_paranoid

  after_create :send_notification

  belongs_to :user, class_name: 'User'
  belongs_to :debate, class_name: 'Debate'

  delegate :email, to: :user, prefix: true

  def started
    {
      started_by: "#{user.try(:first_name)} #{user.try(:last_name)}",
      started_email: user_email,
      photo: user.profile_photo_url
    }
  end

  private

  def send_notification
    title = 'Nueva respuesta de Debate'

    unless user_id == debate.user_id
      NotificationService.new(debate.user, title, "El usuario #{user.email} ha agregado una nueva respuesta en tu debate", debate_id, debate.class.to_s).exec
    end

    debate.responses.where.not(user_id: user_id).each do |resp|
      NotificationService.new(resp.user, title, "El usuario #{user.email} ha agregado una nueva respuesta a un debate en el que participaste", debate_id, debate.class.to_s).exec
    end
  end
end
