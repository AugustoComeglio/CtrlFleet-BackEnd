# frozen_string_literal: true

class NotificationChannel < ApplicationCable::Channel
  # Called when the consumer successfully subscribes to this channel
  def subscribed
    stream_from 'notification_channel'
  end
  
  def unsubscribed
    # Wow! Action Cable cannot handle this
    # transmit type: 'success', data: 'Notifications turned off. Good-bye!'
  end
end

# Asi es como se deberia enviar una notificacion, en el objeto podemos mandar lo que quisieramos
# ActionCable.server.broadcast(
#   "notification_channel",
#   {text: 'asdasdasd', user_id: 4}
# )