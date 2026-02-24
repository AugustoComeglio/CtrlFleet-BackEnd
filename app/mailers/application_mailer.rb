class ApplicationMailer < ActionMailer::Base
  default from: 'no-replay@ctrlfleet.com'
  layout 'mailer'

  def from_address
    'no-replay@ctrlfleet.com.ar'
  end
end
