class PostsController < ApplicationController
  def index
    if current_user.latitude.nil?
      redirect_to edit_user_path(current_user)
      flash[:alert] = "Merci de renseigner votre adresse !"
    else
      @posts = current_user.posts_in_scope
      @post = Post.new
    end
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

  def like
    set_post
    @post.liked_by current_user
    respond_to do |format|
      format.html { redirect_to :index }
      format.js
    end
  end

  def unlike
    set_post
    @post.unliked_by current_user
    respond_to do |format|
      format.html { redirect_to :index }
      format.js
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

