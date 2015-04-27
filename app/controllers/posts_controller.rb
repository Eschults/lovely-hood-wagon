class PostsController < ApplicationController
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
    set_post
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post
    if @comment.save
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

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end

