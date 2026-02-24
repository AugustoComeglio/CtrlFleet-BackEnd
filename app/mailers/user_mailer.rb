# frozen_string_literal: true

class UserMailer < ApplicationMailer
  include Devise::Mailers::Helpers
  layout 'layouts/email'

  def confirmation_instructions(user, token, _opts = {})
    @banner = 'https://ctrlfleet-public.s3.sa-east-1.amazonaws.com/app/public/assets/mailing/header-mailing-dark.jpeg'
    @user = user
    @confirmation_url = "http://localhost:4200/reset-password?token=#{token}"

    mail to: @user.email, from: from_address, subject: I18n.t(:confirmation_instructions_subject)
  end

  def reset_password_instructions(user, token, *_args)
    @banner = 'https://ctrlfleet-public.s3.sa-east-1.amazonaws.com/app/public/assets/mailing/header-mailing-dark.jpeg'
    @user = user
    @edit_password_reset_url = "http://localhost:4200/reset-password?token=#{token}"

    mail to: @user.email, from: from_address, subject: I18n.t(:reset_password_instructions_subject)
  end

  def notification_email(user, title, subtitle)
    @banner = 'https://ctrlfleet-public.s3.sa-east-1.amazonaws.com/app/public/assets/mailing/header-mailing-dark.jpeg'
    @user = user
    @title = title
    @subtitle = subtitle
    @notification_url = "http://localhost:4200/gestionar-debates/#{@user.get_doorkeeper_token.token}"

    mail to: @user.email, from: from_address, subject: I18n.t(:notification_email_subject)
  end

  def password_change(_record, _opts = {})
    true
  end
end
