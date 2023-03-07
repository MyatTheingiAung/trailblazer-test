class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # function: index
  # show user list
  def index
    run User::Operation::Index do |result|
      @users = result[:users]
    end
  end

  def new
    run User::Operation::Create::Present
  end

  def create
    run User::Operation::Create do |_result|
      return redirect_to root_path
    end
    render :new
  end

  def edit
    run User::Operation::Update::Present
  end

  def update
    run User::Operation::Update do |_result|
      return redirect_to root_path
    end
    if result.failure?
      p "failure"
    end
    # render :edit
  end

  def destroy
    run User::Operation::Destroy

    return redirect_to root_path
  end

  def profile
  end

  def profile_edit
  end

  def password_change
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @form = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password_digest, :phone, :address, :role, :birthday)
  end
end
