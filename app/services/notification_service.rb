# frozen_string_literal: true

class NotificationService
  def initialize(user, title, message, record_id, record_type)
    @user = user
    @title = title
    @message = message
    @record_type = record_type.downcase
    @record_id = record_id
  end

  def exec
    @noti = persist_notification
    notification_types = EnableNotificationType.where(user_id: @user.id).joins(:notification_type).pluck('notification_types.name')

    if notification_types.include? 'popup'
      actioncable_notification
    elsif notification_types.include? 'mail'
      mailer_notification
    end
  end

  def actioncable_notification
    ActionCable.server.broadcast('notification_channel', { title: @title, message: @message, user_id: @user.id, record_type: @record_type, record_id: @record_id, notification_id: @noti.id, viewed_at: @noti.viewed_at })
  end

  def mailer_notification
    UserMailer.notification_email(@user, @title, @message).deliver_now
  end

  def persist_notification
    Notification.create(title: @title, message: @message, user_id: @user.try(:id), record_type: @record_type, record_id: @record_id)
  end
end