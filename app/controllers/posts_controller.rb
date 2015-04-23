class PostsController < ApplicationController
  before_action :set_offer, only: [:update]
  def index
    @posts = []
    current_user.neighbors.each do |neighbor|
      neighbor.posts.each do |post|
        @posts << post
      end
    end
    @posts << current_user.posts.flatten
    @posts.flatten!.sort_by!(&:created_at)
  end

  def create
    @post = current_user.posts.new(post_params)
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

