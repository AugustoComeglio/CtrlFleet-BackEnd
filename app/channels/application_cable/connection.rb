# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
   
    def connect
      self.current_user = verify_access_token
    end

    def disconnect
      ActionCable.server.broadcast(
        "notification_channel",
        type: 'alert', data: "#{current_user} disconnected"
      )
    end
    
    private

    def verify_access_token
      token = request.params["access_token"]
      # Verify your token here and return a user when verified
    end
  end
end
