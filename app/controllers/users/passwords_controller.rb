class Users::PasswordsController < Devise::PasswordsController
  before_action :check_guest, only: :create

  def check_guest
    redirect_to root_path, alert: 'Not allowed to change or delete guest user.' if params[:user][:email].casecmp('guest@example.com').zero?
  end
end
