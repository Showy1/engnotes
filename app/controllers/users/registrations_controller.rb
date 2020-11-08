class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: %i[update destroy]

  def check_guest
    redirect_to root_path, alert: 'Not allowed to change or delete guest user.' if resource.email == 'guest@example.com'
  end
end
