class CtrlfleetAccessToken < ApplicationRecord
  include ::Doorkeeper::Orm::ActiveRecord::Mixins::AccessToken

  self.table_name = "oauth_access_tokens"

  def destroy_me!
    destroy
  end
end