# frozen_string_literal: true

class ReportMailer < ApplicationMailer
  layout 'layouts/email'

  def send_report(user_email, public_url, filename, date_range, _resend: false)
    @user = User.find_by email: user_email
    @filename = filename
    @date_range = date_range.to_s
    @banner = 'https://ctrlfleet-public.s3.sa-east-1.amazonaws.com/app/public/assets/mailing/header-mailing-dark.jpeg'
    @public_url = public_url
    mail(to: user_email, from: from_address, subject: "CtrlFleet | #{@filename.split('.').first.titleize}")
  end
end
