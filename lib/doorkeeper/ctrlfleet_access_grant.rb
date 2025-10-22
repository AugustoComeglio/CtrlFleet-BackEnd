class CtrlfleetAccessGrant < ApplicationRecord
  include ::Doorkeeper::Orm::ActiveRecord::Mixins::AccessGrant

  self.table_name = "oauth_access_grants"

  def destroy_me!
    destroy
  end
end