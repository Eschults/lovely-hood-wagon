class PostsController < ApplicationController
  def index
    if current_user.latitude.nil?
      redirect_to edit_user_path(current_user)
      flash[:alert] = "Merci de renseigner votre adresse !"
    else
      @posts = current_user.posts_in_scope
      @post = Post.new
      @activities = PublicActivity::Activity.order("created_at desc").where(owner: current_user.neighbors_lh_and_self)
      @items = @posts + @activities
      @items = @items.sort_by(&:created_at).reverse
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    words_array = @post.content.split(" ")
    if @post.save
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to :back }
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
      @comment.create_activity :update, owner: current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def update_activity
    set_activity
    @comment = ActivityComment.new(activity_comment_params)
    @comment.user = current_user
    @comment.activity_id = @activity.id
    if @comment.save
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def like
    set_post
    @post.liked_by current_user
    @post.create_activity :like, owner: current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def unlike
    set_post
    @post.unliked_by current_user
    PublicActivity::Activity.find_by(owner: current_user, trackable: @post).destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def like_activity
    set_activity
    @activity.liked_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def unlike_activity
    set_activity
    @activity.unliked_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_activity
    @activity = PublicActivity::Activity.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def activity_comment_params
    params.require(:activity_comment).permit(:content)
  end

end

