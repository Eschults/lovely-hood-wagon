require 'uri'
class PostsController < ApplicationController
  def index
    name_and_address_validations
    if current_user.latitude.nil?
      redirect_to edit_user_path(current_user)
      flash.now[:alert] = "Renseignez votre adresse nous permettre de déterminer votre voisinage"
    end
    @posts = current_user.posts_in_scope
    @post = Post.new
    if current_user.admin
      @activities = PublicActivity::Activity.order("created_at desc")
    else
      @activities = PublicActivity::Activity.order("created_at desc").where(owner: current_user.neighbors_lh_and_self)
    end
    @items = @posts + @activities
    @items = @items.sort_by(&:created_at).reverse
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    url = URI.extract(@post.content, /https?.*/)
    if url.size > 0
      page = MetaInspector.new(url.first)
      @post.link_url = url.first
      @post.link_title = page.title
      @post.link_image = page.images.best
      @post.link_description = page.description
      @post.content = @post.content.split(url.first).join
      @post.content = "***" if @post.content == ""
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

  def name_and_address_validations
    if current_user.first_name != ""
      if current_user.last_name != ""
        if current_user.street != ""
          if current_user.zip_code != ""
            if current_user.city != ""

            else
              redirect_to edit_user_path(current_user)
              flash.keep[:alert] = "Merci de renseigner votre ville"
            end
          else
            redirect_to edit_user_path(current_user)
            flash.keep[:alert] = "Merci de renseigner votre code postal"
          end
        else
          redirect_to edit_user_path(current_user)
          flash.keep[:alert] = "Merci de renseigner votre rue"
        end
      else
        redirect_to edit_user_path(current_user)
        flash.keep[:alert] = "Merci de renseigner votre nom de famille"
      end
    else
      redirect_to edit_user_path(current_user)
      flash.keep[:alert] = "Merci de renseigner votre prénom"
    end
  end
end

