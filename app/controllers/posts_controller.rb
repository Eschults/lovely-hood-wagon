class PostsController < ApplicationController
  before_action :set_offer, only: [:update]
  def index
    @posts = current_user.posts_in_scope
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      respond_to do |format|
        format.html { redirect_to :index }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to :index }
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

