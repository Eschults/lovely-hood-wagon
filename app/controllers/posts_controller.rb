class PostsController < ApplicationController
  before_action :set_offer, only: [:update]
  def index
    @posts = policy_scope(Post)
  end

  def create
    @post = current_user.posts.new(post_params)
    authorize @post
    if @post.save
      respond_to do |format|
        format.html { render :index }
        format.js
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.js
      end
    end
  end

  def update
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end

