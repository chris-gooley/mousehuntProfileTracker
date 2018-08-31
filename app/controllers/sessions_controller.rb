class SessionsController < ApplicationController
  skip_before_action :require_hunter, only: [:new, :create, :forgot_password, :reset_password]

  def new
  end

  def create
    if request.post?
      if @hunter = Hunter.find_by(email: params[:email].downcase.strip).try(:authenticate, params[:password] )
        self.current_hunter = @hunter
        redirect_to profile_path
      else
        flash.now[:alert] = "Sorry, bad email/password combination."
        render 'new'
      end
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: 'See you soon!'
  end

  def forgot_password
    if request.post?
      if @hunter = Hunter.find_by(email: params[:email_address])
        @hunter.update_attribute(:reset_token, SecureRandom.hex(16))
        AccountMailer.forgot_password(@hunter).deliver_now
        flash.now[:notice] = 'A reset link has been delivered to your email address.'
      else
        flash.now[:alert] = "Sorry couldn't find that email address"
      end
    end
  end

  def reset_password
    if params[:reset_token].present? && @hunter = Hunter.find_by(reset_token: params[:reset_token])
      if request.post?
        if @hunter.update_attributes(password_params)
          @hunter.update_attribute(:reset_token, nil)
          redirect_to login_path, notice: 'Password updated, try logging in.'
        else
          flash.now[:alert] = 'Password/Password Confirmation invalid, please try again.'
        end
      end
    else
      redirect_to login_path, alert: 'Sorry, that is an invalid or expired token'
    end
  end

private
  def password_params
    params.permit(:password, :password_confirmation)
  end
end
