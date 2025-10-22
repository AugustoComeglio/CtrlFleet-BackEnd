# frozen_string_literal: true

module CtrlfleetTokenResponse
  def body
    user = User.find token.resource_owner_id

    additional_data = {
      'user_data' => {
        'id' => user.id,
        'email' => user.email,
        'type' => user.type_name
      }
    }

    super.merge(additional_data)
  end
end
