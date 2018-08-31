class AccountMailer < ApplicationMailer

  def forgot_password(hunter)
    @hunter = hunter
    mail(
      to: hunter.email,
      subject: 'Mousehunter Tracker: Forgot Password'
    )
  end
end
