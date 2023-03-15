class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy profile password_change actual_password_change]

  # function: index
  # show user list
  def index
    run User::Operation::Index do |result|
      @users = result[:users]
    end
    respond_to do |format|
      format.html
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachment; filename=users-#{DateTime.now.strftime("%d%m%Y%H%M")}.csv"
        render template: 'users/index.csv.erb'
      end
    end
  end

  # function: import
  # users import
  def import
    run User::Operation::Import do |result|
      redirect_to root_path, notice: 'User Upload Successfully!'
    end
    if result.failure? && result[:file] || result[:file]
      flash[:file] = result[:file]
      redirect_to users_path
    end
  end

  # function: new
  # show create form
  def new
    run User::Operation::Create::Present
  end

  # function: create
  # create user
  # params user
  def create
    run User::Operation::Create do |_result|
      return redirect_to root_path, notice: 'User Create Successfully!'
    end

    render :new
  end

  # function: edit
  # show edit form
  def edit
    authorize! @user
    run User::Operation::Update::Present
  end

  # function: create
  # update user
  # params user
  def update
    run User::Operation::Update do |_result|
      UserMailer.example(User.new(email: 'scm.myattheingiaung@gmail.com')).deliver
      return redirect_to root_path, notice: 'User Update Successfully!'
    end

    render :edit
  end

  # function: destroy
  # delete user
  def destroy
    run User::Operation::Destroy do |_result|
      return redirect_to root_path, notice: 'User Delete Successfully!'
    end
  end

  # function: profile
  # show details info
  def profile
    run User::Operation::Show do |result|
      @user = result[:model]
      @qr_code = RQRCode::QRCode.new(@user.name)
      @svg = @qr_code.as_svg(
        color: '000',
        shape_rendering: 'crispEdges',
        module_size: 8,
        standalone: true,
        use_path: true
      )
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password_digest, :phone, :address, :role, :birthday)
  end
end
