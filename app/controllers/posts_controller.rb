class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: %i[index show]

  # function: index
  # show post list
  def index
    run Post::Operation::Index do |result|
      @posts = result[:posts]
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
      return redirect_to posts_path, notice: 'User Delete Successfully!'
    end
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
