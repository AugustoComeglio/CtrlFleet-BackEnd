class CtrlfleetApplication < ApplicationRecord
  include ::Doorkeeper::Orm::ActiveRecord::Mixins::Application

  self.table_name = "oauth_applications"

  def destroy_me!
    destroy
  end
end