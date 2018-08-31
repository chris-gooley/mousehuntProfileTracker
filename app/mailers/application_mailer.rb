class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@mail.mousehunter-tracker.com'
  layout 'mailer'
end
