require 'uri'
class PostsController < ApplicationController
  def index
    if current_user.latitude.nil?
      redirect_to edit_user_path(current_user)
      flash.keep[:alert] = t(".complete_profile")
    else
      @posts = current_user.posts_in_scope
      @post = Post.new
      if current_user.admin
        @comments = PublicActivity::Activity.order("created_at desc").where(key: "comment.update").group_by { |a| a.trackable.post }.values.map { |g| g.first }
        @other_activities = PublicActivity::Activity.order("created_at desc").where(key: ["offer.create", "user.update", "post.like"]).group_by(&:trackable_id).values.map { |g| g.first }
      else
        @comments = PublicActivity::Activity.order("created_at desc").where(owner: current_user.neighbors_lh_and_self).where(key: "comment.update").group_by { |a| a.trackable.post }.values.map { |g| g.first }
        @other_activities = PublicActivity::Activity.order("created_at desc").where(owner: current_user.neighbors_lh_and_self).where(key: ["offer.create", "user.update", "post.like"]).group_by(&:trackable_id).values.map { |g| g.first }
      end
      @activities = @comments + @other_activities
      @items = @posts + @activities
      @items = @items.sort_by(&:created_at).reverse
      @items = Kaminari.paginate_array(@items).page(params[:page]).per(15)
      respond_to do |format|
        format.html {}
        format.js
      end
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    url = URI.extract(@post.content, /https?.*/)
    if url.size > 0
      unless url.first.match(/https:\/\/www.lovely-hood.com\//)
        page = MetaInspector.new(url.first)
        @post.link_url = url.first
        @post.link_title = page.title
        @post.link_image = page.images.best
        @post.link_description = page.description
        @post.content = @post.content.split(url.first).join
        @post.content = "***" if @post.content == ""
      end
    end
    if @post.save
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
      if @post.user == User.find_by(first_name: "Lovely Hood")
        @post.send_lh_post_email
      else
        @post.send_post_email
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
      @comment.send_comment_email if @post.user.comment_notif
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
    @post.send_like_email(current_user) if @post.user.like_notif
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
    params.require(:post).permit(:content, :picture)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def activity_comment_params
    params.require(:activity_comment).permit(:content)
  end
end