class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: %i[index show]

  # function: index
  # show post list
  def index
    run Post::Operation::Index, current_user: current_user do |result|
      @posts = result[:posts]
    end
    respond_to do |format|
      format.html
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachment; filename=posts-#{DateTime.now.strftime("%d%m%Y%H%M")}.csv"
        render template: 'posts/index.csv.erb'
      end
    end
  end

  # function: profile
  # show details info
  def show
    run Post::Operation::Show do |result|
      @post = result[:model]
    end
  end

  # function: new
  # show create form
  def new
    run Post::Operation::Create::Present
  end

  # function: create
  # create user
  # params user
  def create
    run Post::Operation::Create do |_result|
      return redirect_to posts_path, notice: 'Post Create Successfully!'
    end

    render :new
  end

  # function: edit
  # show edit form
  def edit
    authorize! @post
    run Post::Operation::Update::Present
  end

  # function: create
  # update post
  # params post
  def update
    run Post::Operation::Update do |_result|
      return redirect_to posts_path, notice: 'Post Update Successfully!'
    end

    render :edit
  end

  # function: destroy
  # delete post
  def destroy
    run Post::Operation::Destroy do |_result|
      return redirect_to posts_path, notice: 'Post Delete Successfully!'
    end
  end

  # function: import
  # posts import
  def import
    run Post::Operation::Import do |result|
      redirect_to posts_path, notice: 'Post Upload Successfully!'
    end
    if result.failure? && result[:file] || result[:file]
      flash[:file] = result[:file]
      redirect_to posts_path
    end
  end

  # function: import
  # posts copy form
  def copy_form
    run Post::Operation::Update::Present
  end

  def copy
    run Post::Operation::Copy do |_result|
      return redirect_to posts_path, notice: 'Post Copy Successfully!'
    end
    render :copy_form
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :privacy)
    end
end
